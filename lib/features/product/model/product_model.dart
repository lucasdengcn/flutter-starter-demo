import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String category;
  final int stockQuantity;
  final Map<String, dynamic>? attributes;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.stockQuantity,
    this.attributes,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
  factory Product.empty() => Product(
    id: '',
    name: '',
    price: 0.0,
    description: '',
    imageUrl: '',
    category: '',
    stockQuantity: 0,
    attributes: {},
  );
}
