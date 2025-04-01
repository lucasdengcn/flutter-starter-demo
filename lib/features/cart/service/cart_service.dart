import 'dart:convert';

import 'package:flutter/services.dart';

import '../../product/service/product_service.dart';
import '../model/cart_model.dart';

class CartService {
  final ProductService _productService;

  CartService(this._productService);

  Future<List<Cart>> getCarts() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/carts.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> cartList = jsonData['carts'];
      return Future.wait(
        cartList.map((json) => Cart.fromJson(json, _productService)),
      );
    } catch (e) {
      throw Exception('Error loading carts: $e');
    }
  }

  Future<Cart?> getCartByUserId(String userId) async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/carts.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> cartList = jsonData['carts'];
      final cartJson = cartList.firstWhere(
        (json) => json['userId'] == userId,
        orElse: () => null,
      );
      if (cartJson == null) return null;
      return Cart.fromJson(cartJson, _productService);
    } catch (e) {
      throw Exception('Error finding cart: $e');
    }
  }
}
