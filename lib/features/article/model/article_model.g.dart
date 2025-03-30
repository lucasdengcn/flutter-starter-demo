// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
  id: json['id'] as String,
  title: json['title'] as String,
  summary: json['summary'] as String,
  content: json['content'] as String,
  imageUrl: json['imageUrl'] as String,
  publishDate: DateTime.parse(json['publishDate'] as String),
  author: json['author'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'summary': instance.summary,
  'content': instance.content,
  'imageUrl': instance.imageUrl,
  'publishDate': instance.publishDate.toIso8601String(),
  'author': instance.author,
  'tags': instance.tags,
};
