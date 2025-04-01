import '../../product/model/product_model.dart';
import '../../product/service/product_service.dart';

class CartItem {
  final Product product;
  int quantity;
  double price;

  CartItem({
    required this.product,
    required this.quantity,
    required this.price,
  });

  double get totalPrice => product.price * quantity;

  CartItem copyWith({Product? product, int? quantity, double? price}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': product.id,
    'quantity': quantity,
    'price': product.price,
  };

  static Future<CartItem> fromJson(
    Map<String, dynamic> json,
    ProductService productService,
  ) async {
    final product = await productService.getProductById(
      json['productId'] as String,
    );
    return CartItem(
      product: product,
      quantity: json['quantity'] as int,
      price: json['price'] as double,
    );
  }
}

class Cart {
  final String? id;
  final String? userId;
  final List<CartItem> items;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Cart({
    this.id,
    this.userId,
    this.items = const [],
    this.createdAt,
    this.updatedAt,
  });

  double get totalAmount {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get itemCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  Cart copyWith({
    String? id,
    String? userId,
    List<CartItem>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Cart(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'items': items.map((e) => e.toJson()).toList(),
    'totalAmount': totalAmount,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  static Future<Cart> fromJson(
    Map<String, dynamic> json,
    ProductService productService,
  ) async {
    final cartItems = await Future.wait(
      (json['items'] as List<dynamic>).map(
        (e) => CartItem.fromJson(e as Map<String, dynamic>, productService),
      ),
    );
    return Cart(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      items: cartItems,
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'] as String)
              : null,
      updatedAt:
          json['updatedAt'] != null
              ? DateTime.parse(json['updatedAt'] as String)
              : null,
    );
  }
}
