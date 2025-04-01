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

  List<Order> get orders => _orders;
  Order? get selectedOrder => _selectedOrder;

  Future<void> loadOrders() async {
    await handleAsyncOperation(() async {
      _orders = await _orderService.getOrdersByUserId();
    });
  }

  Future<void> loadOrderDetails(String orderId) async {
    await handleAsyncOperation(() async {
      _selectedOrder = await _orderService.getOrderById(orderId);
    });
  }

  Future<Order?> createOrder({
    required String userId,
    required List<OrderItem> items,
    required double totalAmount,
    required OrderAddress shippingAddress,
  }) async {
    Order? order;
    await handleAsyncOperation(() async {
      order = await _orderService.createOrder(
        userId: userId,
        items: items,
        totalAmount: totalAmount,
        shippingAddress: shippingAddress,
      );
      _orders = [order!, ..._orders];
    });
    return order;
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
