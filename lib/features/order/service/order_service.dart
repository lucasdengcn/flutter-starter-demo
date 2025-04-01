import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../../core/service/logger_service.dart';
import '../model/order_model.dart';

const String ordersAssetPath = 'assets/data/orders.json';

class OrderService {
  final LoggerService _logger = GetIt.instance<LoggerService>();
  final String currentUserId = 'u1';

  Future<List<Order>> getOrders() async {
    try {
      final String jsonString = await rootBundle.loadString(ordersAssetPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> orderList = jsonData['orders'];
      return orderList.map((json) => Order.fromJson(json)).toList();
    } catch (e) {
      _logger.e('Error loading orders', [e, StackTrace.current]);
      throw Exception('Error loading orders: $e');
    }
  }

  Future<List<Order>> getOrdersByUserId() async {
    try {
      final orders = await getOrders();
      return orders.where((order) => order.userId == currentUserId).toList();
    } catch (e) {
      _logger.e('Error getOrdersByUserId', [e, StackTrace.current]);
      throw Exception('Error finding orders: $e');
    }
  }

  Future<Order> getOrderById(String orderId) async {
    try {
      final orders = await getOrders();
      final order = orders.firstWhere(
        (order) => order.id == orderId,
        orElse: () => throw Exception('Order not found'),
      );
      return order;
    } catch (e) {
      _logger.e('Error getOrderById', [e, StackTrace.current]);
      throw Exception('Error finding order details: $e');
    }
  }

  Future<Order> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      final order = await getOrderById(orderId);
      return order.copyWith(status: newStatus, updatedAt: DateTime.now());
    } catch (e) {
      _logger.e('Error updating order status', [e, StackTrace.current]);
      throw Exception('Error updating order status: $e');
    }
  }

  Future<Order> createOrder({
    required String userId,
    required List<OrderItem> items,
    required double totalAmount,
    required OrderAddress shippingAddress,
  }) async {
    try {
      final newOrder = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        items: items,
        totalAmount: totalAmount,
        status: OrderStatus.pending,
        shippingAddress: shippingAddress,
        createdAt: DateTime.now(),
      );
      return newOrder;
    } catch (e) {
      _logger.e('Error creating order', [e, StackTrace.current]);
      throw Exception('Error creating order: $e');
    }
  }
}
