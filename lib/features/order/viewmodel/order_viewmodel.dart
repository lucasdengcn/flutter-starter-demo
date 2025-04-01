import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../core/viewmodel/base_viewmodel.dart';
import '../model/order_model.dart';
import '../service/order_service.dart';

class OrderViewModel extends BaseViewModel {
  final OrderService _orderService = GetIt.I<OrderService>();
  List<Order> _orders = [];
  Order? _selectedOrder;
  bool _isLastPage = false;
  int _currentPage = 1;
  static const int _pageSize = 10;

  List<Order> get orders => _orders;
  Order? get selectedOrder => _selectedOrder;
  bool get isLastPage => _isLastPage;

  Future<void> refreshOrders() async {
    _currentPage = 1;
    _isLastPage = false;
    _orders.clear();
    await loadOrders();
  }

  Future<void> loadOrders() async {
    if (_isLastPage) return;

    await handleAsyncOperation(() async {
      final newOrders = await _orderService.getOrdersByUserId(
        page: _currentPage,
        pageSize: _pageSize,
      );

      if (newOrders.isEmpty || newOrders.length < _pageSize) {
        _isLastPage = true;
      }

      if (_currentPage == 1) {
        _orders = newOrders;
      } else {
        _orders.addAll(newOrders);
      }

      _currentPage++;
    });
  }

  Future<void> loadMoreOrders() async {
    await loadOrders();
  }

  Future<void> loadOrderDetails(String orderId) async {
    await handleAsyncOperation(() async {
      _selectedOrder = await _orderService.getOrderById(orderId);
    });
  }

  Future<bool> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    bool success = false;
    await handleAsyncOperation(() async {
      final updatedOrder = await _orderService.updateOrderStatus(
        orderId,
        newStatus,
      );

      final orderIndex = _orders.indexWhere((order) => order.id == orderId);
      if (orderIndex >= 0) {
        _orders[orderIndex] = updatedOrder;
      }

      if (_selectedOrder?.id == orderId) {
        _selectedOrder = updatedOrder;
      }

      success = true;
    });
    return success;
  }

  void clearSelectedOrder() {
    _selectedOrder = null;
    notifyListeners();
  }

  Color getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.shipped:
        return Colors.indigo;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
      case OrderStatus.completed:
        return Colors.green;
    }
  }

  String getStatusText(OrderStatus status) {
    return status.toString().split('.').last.toUpperCase();
  }

  String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  String formatItemCount(int count) {
    return count == 1 ? '1 item' : '$count items';
  }

  String formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  String formatQuantity(int quantity) {
    return 'Quantity: $quantity';
  }

  String formatTotal(double total) {
    return 'Total: ${formatPrice(total)}';
  }
}
