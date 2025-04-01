import 'package:json_annotation/json_annotation.dart';

import '../../cart/model/cart_model.dart';

part 'order_model.g.dart';

@JsonEnum()
enum OrderStatus {
  pending,
  processing,
  completed,
  shipped,
  delivered,
  cancelled,
}

@JsonSerializable()
class OrderAddress {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  OrderAddress({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory OrderAddress.fromJson(Map<String, dynamic> json) =>
      _$OrderAddressFromJson(json);
  Map<String, dynamic> toJson() => _$OrderAddressToJson(this);
}

@JsonSerializable()
class OrderItem {
  final String productId;
  @JsonKey(name: 'name', required: false)
  final String? productName;
  final double price;
  final int quantity;
  @JsonKey(name: 'imageUrl', required: false)
  final String? imageUrl;

  OrderItem({
    required this.productId,
    this.productName,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  factory OrderItem.fromCartItem(CartItem cartItem) {
    return OrderItem(
      productId: cartItem.product.id,
      productName: cartItem.product.name,
      price: cartItem.product.price,
      quantity: cartItem.quantity,
      imageUrl: cartItem.product.imageUrl,
    );
  }

  double get total => price * quantity;
}

@JsonSerializable()
class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalAmount;
  final OrderStatus status;
  final OrderAddress shippingAddress;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.shippingAddress,
    required this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order copyWith({
    String? id,
    String? userId,
    List<OrderItem>? items,
    double? totalAmount,
    OrderStatus? status,
    OrderAddress? shippingAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
