import 'package:flutter/foundation.dart';

import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  Product? _selectedProduct;
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _productService.getProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProductDetails(String productId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedProduct = await _productService.getProductById(productId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProductsByCategory(String category) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _productService.getProductsByCategory(category);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSelectedProduct() {
    _selectedProduct = null;
    notifyListeners();
  }
}
