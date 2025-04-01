// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  description: json['description'] as String,
  imageUrl: json['imageUrl'] as String,
  category: json['category'] as String,
  stockQuantity: (json['stockQuantity'] as num).toInt(),
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'category': instance.category,
  'stockQuantity': instance.stockQuantity,
  'attributes': instance.attributes,
};
