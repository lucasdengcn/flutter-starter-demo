import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class Article {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String imageUrl;
  final String? videoUrl;
  final String? audioUrl;
  final DateTime publishDate;
  final String author;
  final List<String> tags;
  final int likesCount;
  final int thumbsUpCount;

  Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.imageUrl,
    this.videoUrl,
    this.audioUrl,
    required this.publishDate,
    required this.author,
    required this.tags,
    this.likesCount = 0,
    this.thumbsUpCount = 0,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
