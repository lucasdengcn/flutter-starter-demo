import 'package:flutter/foundation.dart';

import '../model/order_model.dart';
import '../service/order_service.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderService _orderService = OrderService();
  List<Order> _orders = [];
  Order? _selectedOrder;
  bool _isLoading = false;
  String? _error;

  List<Order> get orders => _orders;
  Order? get selectedOrder => _selectedOrder;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadOrders(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _orders = await _orderService.getOrdersByUserId(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadOrderDetails(String orderId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedOrder = await _orderService.getOrderById(orderId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Order?> createOrder({
    required String userId,
    required List<OrderItem> items,
    required double totalAmount,
    required OrderAddress shippingAddress,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final order = await _orderService.createOrder(
        userId: userId,
        items: items,
        totalAmount: totalAmount,
        shippingAddress: shippingAddress,
      );

      _orders = [order, ..._orders];
      return order;
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
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

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSelectedOrder() {
    _selectedOrder = null;
    notifyListeners();
  }
}
