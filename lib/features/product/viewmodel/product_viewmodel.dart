import 'package:flutter/material.dart';

import '../../../core/viewmodel/base_viewmodel.dart';
import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductViewModel extends BaseViewModel {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  Product? _selectedProduct;
  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;
  int _quantity = 1;
  int get quantity => _quantity;

  double get totalPrice => (_selectedProduct?.price ?? 0) * _quantity;

  void incrementQuantity() {
    if (_selectedProduct != null &&
        _quantity < _selectedProduct!.stockQuantity) {
      _quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  Future<void> addToCart() async {
    if (_selectedProduct == null) return;

    await handleAsyncOperation(() async {
      // TODO: Implement cart service integration
      // await _cartService.addToCart(_selectedProduct!.id, _quantity);
      _quantity = 1; // Reset quantity after adding to cart
    });
  }

  void navigateToCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart');
  }

  Future<void> loadProducts() async {
    await handleAsyncOperation(() async {
      _products = await _productService.getProducts();
    });
  }

  Future<void> loadProductDetails(String productId) async {
    await handleAsyncOperation(() async {
      _selectedProduct = await _productService.getProductById(productId);
    });
  }

  Future<void> loadProductsByCategory(String category) async {
    await handleAsyncOperation(() async {
      _products = await _productService.getProductsByCategory(category);
    });
  }

  void clearSelectedProduct() {
    _selectedProduct = null;
    notifyListeners();
  }
}
