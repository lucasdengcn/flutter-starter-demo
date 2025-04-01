import 'package:flutter/foundation.dart';

import '../../product/model/product_model.dart';
import '../model/cart_model.dart';

class CartViewModel extends ChangeNotifier {
  Cart _cart = Cart();
  Cart get cart => _cart;

  void addToCart(Product product, int quantity) {
    final existingItemIndex = _cart.items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingItemIndex >= 0) {
      // Update existing item quantity
      final existingItem = _cart.items[existingItemIndex];
      final newQuantity = existingItem.quantity + quantity;

      if (newQuantity <= product.stockQuantity) {
        final updatedItems = List<CartItem>.from(_cart.items);
        updatedItems[existingItemIndex] = existingItem.copyWith(
          quantity: newQuantity,
        );
        _cart = _cart.copyWith(items: updatedItems);
        notifyListeners();
      }
    } else {
      // Add new item
      if (quantity <= product.stockQuantity) {
        final updatedItems = List<CartItem>.from(_cart.items);
        updatedItems.add(CartItem(product: product, quantity: quantity));
        _cart = _cart.copyWith(items: updatedItems);
        notifyListeners();
      }
    }
  }

  void removeFromCart(String productId) {
    final updatedItems =
        _cart.items.where((item) => item.product.id != productId).toList();
    _cart = _cart.copyWith(items: updatedItems);
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity) {
    final itemIndex = _cart.items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (itemIndex >= 0) {
      final item = _cart.items[itemIndex];
      if (newQuantity <= item.product.stockQuantity && newQuantity > 0) {
        final updatedItems = List<CartItem>.from(_cart.items);
        updatedItems[itemIndex] = item.copyWith(quantity: newQuantity);
        _cart = _cart.copyWith(items: updatedItems);
        notifyListeners();
      }
    }
  }

  void clearCart() {
    _cart = Cart();
    notifyListeners();
  }
}
