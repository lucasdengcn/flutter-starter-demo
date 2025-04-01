import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/product_model.dart';

class ProductService {
  Future<List<Product>> getProducts() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/products.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> productList = jsonData['products'];
      return productList.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error loading products: $e');
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final products = await getProducts();
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      throw Exception('Error finding product: $e');
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final products = await getProducts();
      return products.where((product) => product.category == category).toList();
    } catch (e) {
      throw Exception('Error fetching products by category: $e');
    }
  }
}
