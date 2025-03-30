import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class Article {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String imageUrl;
  final DateTime publishDate;
  final String author;
  final List<String> tags;

  Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.imageUrl,
    required this.publishDate,
    required this.author,
    required this.tags,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
