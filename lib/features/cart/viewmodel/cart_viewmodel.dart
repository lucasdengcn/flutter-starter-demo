import 'package:get_it/get_it.dart';

import '../../../core/viewmodel/base_viewmodel.dart';
import '../../product/model/product_model.dart';
import '../model/cart_model.dart';
import '../service/cart_service.dart';

class CartViewModel extends BaseViewModel {
  //
  final CartService _cartService = GetIt.I<CartService>();

  Cart get cart => _cartService.currentCart ?? Cart();
  String get formattedTotalAmount => _cartService.formattedTotalAmount;
  String get itemCountText => _cartService.itemCountText;
  bool get hasItems => _cartService.hasItems;

  Future<void> loadUserCart() async {
    await handleAsyncOperation(() async {
      await _cartService.loadCurrentCart('u3');
      notifyListeners();
    });
  }

  Future<void> addToCart(Product product, int quantity) async {
    await handleAsyncOperation(() async {
      try {
        await _cartService.addToCart(product, quantity);
        notifyListeners();
      } catch (e) {
        setError(e.toString());
      }
    });
  }

  void removeFromCart(String productId) {
    try {
      _cartService.removeFromCart(productId);
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    await handleAsyncOperation(() async {
      try {
        await _cartService.updateQuantity(productId, newQuantity);
        notifyListeners();
      } catch (e) {
        setError(e.toString());
      }
    });
  }

  Future<void> clearCart() async {
    await handleAsyncOperation(() async {
      await _cartService.clearCart();
      notifyListeners();
    });
  }

  bool isProductInStock(Product product, int quantity) {
    return _cartService.isProductInStock(product, quantity);
  }

  bool hasEnoughStock(String productId, int quantity) {
    return _cartService.hasEnoughStock(productId, quantity);
  }
}
