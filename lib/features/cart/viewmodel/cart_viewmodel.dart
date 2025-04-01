import 'package:get_it/get_it.dart';

import '../../../core/viewmodel/base_viewmodel.dart';
import '../../product/model/product_model.dart';
import '../model/cart_model.dart';
import '../service/cart_service.dart';

class CartViewModel extends BaseViewModel {
  final CartService _cartService = GetIt.I<CartService>();
  Cart _cart = Cart();
  Cart get cart => _cart;

  String get formattedTotalAmount => _cart.totalAmount.toStringAsFixed(2);

  String get itemCountText => '${_cart.itemCount} items';

  bool get hasItems => _cart.itemCount > 0;

  Future<void> loadUserCart(String userId) async {
    await handleAsyncOperation(() async {
      final userCart = await _cartService.getCartByUserId(userId);
      if (userCart != null) {
        _cart = userCart;
        notifyListeners();
      }
    });
  }

  Future<void> addToCart(Product product, int quantity) async {
    if (quantity <= 0) {
      setError('Quantity must be greater than 0');
      return;
    }

    if (quantity > product.stockQuantity) {
      setError('Not enough stock available');
      return;
    }
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

  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (newQuantity <= 0) {
      setError('Quantity must be greater than 0');
      return;
    }
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

  Future<void> clearCart() async {
    await handleAsyncOperation(() async {
      _cart = Cart();
      notifyListeners();
    });
  }

  bool isProductInStock(Product product, int quantity) {
    return quantity <= product.stockQuantity;
  }

  bool hasEnoughStock(String productId, int quantity) {
    final item = _cart.items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product.empty(), quantity: 0),
    );
    return quantity <= item.product.stockQuantity;
  }
}
