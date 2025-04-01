import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/order_model.dart';

const String ordersAssetPath = 'assets/data/orders.json';

class OrderService {
  Future<List<Order>> getOrders() async {
    try {
      final String jsonString = await rootBundle.loadString(ordersAssetPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> orderList = jsonData['orders'];
      return orderList.map((json) => Order.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error loading orders: $e');
    }
  }

  Future<List<Order>> getOrdersByUserId(String userId) async {
    try {
      final orders = await getOrders();
      return orders.where((order) => order.userId == userId).toList();
    } catch (e) {
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
      throw Exception('Error finding order details: $e');
    }
  }

  Future<Order> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      final order = await getOrderById(orderId);
      return order.copyWith(status: newStatus, updatedAt: DateTime.now());
    } catch (e) {
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
      throw Exception('Error creating order: $e');
    }
  }
}
