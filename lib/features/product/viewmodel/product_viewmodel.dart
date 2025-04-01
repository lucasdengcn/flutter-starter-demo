import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../core/viewmodel/base_viewmodel.dart';
import '../../cart/service/cart_service.dart';
import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductViewModel extends BaseViewModel {
  final ProductService _productService = GetIt.I<ProductService>();
  final CartService _cartService = GetIt.I<CartService>();
  List<Product> _products = [];
  Product? _selectedProduct;
  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;
  int _quantity = 1;
  int get quantity => _quantity;

  double get totalPrice => (_selectedProduct?.price ?? 0) * _quantity;

  String formatPrice(double price) => '\$${price.toStringAsFixed(2)}';

  String get formattedPrice =>
      _selectedProduct != null
          ? formatPrice(_selectedProduct!.price)
          : '\$0.00';

  String get formattedTotalPrice => '\$${totalPrice.toStringAsFixed(2)}';

  bool get isInStock =>
      _selectedProduct != null && _selectedProduct!.stockQuantity > 0;

  String getStockStatusText(int stockQuantity) =>
      stockQuantity > 0 ? 'In Stock: $stockQuantity' : 'Out of Stock';

  Color getStockStatusColor(int stockQuantity) =>
      stockQuantity > 0 ? Colors.green : Colors.red;

  String get stockStatus =>
      isInStock ? 'Add to Cart - $formattedTotalPrice' : 'Out of Stock';

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

  String? _successMessage;
  String? get successMessage => _successMessage;

  Future<void> addToCart() async {
    if (_selectedProduct == null) return;

    if (_quantity <= 0) {
      setError('Quantity must be greater than 0');
      return;
    }

    if (_quantity > _selectedProduct!.stockQuantity) {
      setError('Not enough stock available');
      return;
    }

    await handleAsyncOperation(() async {
      await _cartService.addToCart(_selectedProduct!, _quantity);
      _quantity = 1; // Reset quantity after adding to cart
      _successMessage = 'Added to cart successfully';
    });
  }

  @override
  void setError(String? error) {
    super.setError(error);
    _successMessage = null;
  }

  void clearMessages() {
    setError(null);
    _successMessage = null;
    notifyListeners();
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
