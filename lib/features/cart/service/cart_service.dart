import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../../core/service/logger_service.dart';
import '../../product/model/product_model.dart';
import '../../product/service/product_service.dart';
import '../model/cart_model.dart';

class CartService {
  final LoggerService _logger = GetIt.instance<LoggerService>();
  final ProductService _productService = GetIt.instance<ProductService>();

  // Add this field to store current cart in memory
  Cart? _currentCart;
  Cart? get currentCart => _currentCart;

  CartService();

  bool get hasItems => _currentCart?.items.isNotEmpty ?? false;

  // Add this method to load initial cart
  Future<Cart> loadCurrentCart(String userId) async {
    if (_currentCart != null) return Future.value(_currentCart!);
    try {
      _currentCart = await getCartByUserId(userId);
      _currentCart ??= Cart(userId: userId, items: []);
      return Future.value(_currentCart!);
    } catch (e) {
      _logger.e('Error loading cart:', [e, StackTrace.current]);
      rethrow;
    }
  }

  Future<void> addToCart(Product product, int quantity) async {
    try {
      if (_currentCart == null) {
        await loadCurrentCart('u3');
      }

      if (quantity <= 0) {
        throw Exception('Quantity must be greater than 0');
      }

      if (quantity > product.stockQuantity) {
        throw Exception('Not enough stock available');
      }

      final existingItemIndex = _currentCart!.items.indexWhere(
        (item) => item.product.id == product.id,
      );

      if (existingItemIndex >= 0) {
        final existingItem = _currentCart!.items[existingItemIndex];
        final newQuantity = existingItem.quantity + quantity;

        if (newQuantity > product.stockQuantity) {
          throw Exception('Not enough stock available');
        }
        final updatedItems = List<CartItem>.from(_currentCart!.items);
        updatedItems[existingItemIndex] = existingItem.copyWith(
          quantity: newQuantity,
        );
        _currentCart = _currentCart!.copyWith(items: updatedItems);
      } else {
        final updatedItems = List<CartItem>.from(_currentCart!.items);
        updatedItems.add(
          CartItem(product: product, quantity: quantity, price: product.price),
        );
        _currentCart = _currentCart!.copyWith(items: updatedItems);
      }

      // In a real app, you would also persist to backend here
      _logger.i('Added ${product.name} to cart:$existingItemIndex');
    } catch (e) {
      _logger.e('Error adding to cart: ', [e, StackTrace.current]);
      rethrow;
    }
  }

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
      _logger.e('Error getting cart by user id:', [e, StackTrace.current]);
      rethrow;
    }
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    try {
      if (_currentCart == null) {
        throw Exception('Cart not initialized');
      }

      if (newQuantity <= 0) {
        throw Exception('Quantity must be greater than 0');
      }

      final itemIndex = _currentCart!.items.indexWhere(
        (item) => item.product.id == productId,
      );

      if (itemIndex >= 0) {
        final item = _currentCart!.items[itemIndex];
        if (newQuantity <= item.product.stockQuantity) {
          final updatedItems = List<CartItem>.from(_currentCart!.items);
          updatedItems[itemIndex] = item.copyWith(quantity: newQuantity);
          _currentCart = _currentCart!.copyWith(items: updatedItems);
        } else {
          throw Exception('Not enough stock available');
        }
      }
    } catch (e) {
      _logger.e('Error updating quantity:', [e, StackTrace.current]);
      rethrow;
    }
  }

  void removeFromCart(String productId) {
    try {
      if (_currentCart == null) {
        throw Exception('Cart not initialized');
      }

      final updatedItems =
          _currentCart!.items
              .where((item) => item.product.id != productId)
              .toList();
      _currentCart = _currentCart!.copyWith(items: updatedItems);
    } catch (e) {
      _logger.e('Error removing from cart:', [e, StackTrace.current]);
      rethrow;
    }
  }

  Future<void> clearCart() async {
    try {
      _currentCart = Cart();
    } catch (e) {
      _logger.e('Error clearing cart:', [e, StackTrace.current]);
      rethrow;
    }
  }

  bool isProductInStock(Product product, int quantity) {
    return quantity <= product.stockQuantity;
  }

  bool hasEnoughStock(String productId, int quantity) {
    final item = _currentCart?.items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product.empty(), quantity: 0, price: 0.0),
    );
    return quantity <= (item?.product.stockQuantity ?? 0);
  }
}
