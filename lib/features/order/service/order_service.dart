import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../../core/service/logger_service.dart';
import '../../cart/model/cart_model.dart';
import '../../checkout/model/checkout_model.dart';
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

  Future<Order> createOrder(
    Cart cart,
    ShippingDetails shippingDetails,
    PaymentMethod paymentMethod,
  ) async {
    try {
      final orderId =
          'ORD-${DateTime.now().millisecondsSinceEpoch}'; // Generate unique order ID
      final orderItems =
          cart.items
              .map(
                (item) => OrderItem(
                  productId: item.product.id,
                  productName: item.product.name,
                  price: item.product.price,
                  quantity: item.quantity,
                  imageUrl: item.product.imageUrl,
                ),
              )
              .toList();

      final orderAddress = OrderAddress(
        street: shippingDetails.address,
        city: shippingDetails.city,
        state: shippingDetails.state,
        postalCode: shippingDetails.postalCode,
        country: 'US', // Default to US for now
      );

      final order = Order(
        id: orderId,
        userId: currentUserId,
        items: orderItems,
        totalAmount: cart.totalAmount,
        shippingAddress: orderAddress,
        paymentMethod: paymentMethod.name,
        status: OrderStatus.pending,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      _logger.i('Order created successfully: $orderId');
      return order;
    } catch (e) {
      _logger.e('Error creating order:', [e, StackTrace.current]);
      throw Exception('Failed to create order: $e');
    }
  }
}
