import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/article_model.dart';

class ArticleService {
  // In a real app, this would fetch from an API
  // For demo purposes, we'll use mock data
  Future<List<Article>> getArticles() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Read and parse the JSON file
    final jsonString = await rootBundle.loadString('assets/data/articles.json');
    final jsonData = json.decode(jsonString);
    final articlesJson = jsonData['articles'] as List;

    return articlesJson
        .map(
          (articleJson) => Article(
            id: articleJson['id'],
            title: articleJson['title'],
            summary: articleJson['summary'],
            likesCount: articleJson['likesCount'],
            thumbsUpCount: articleJson['thumbsUpCount'],
            content: articleJson['content'],
            imageUrl: articleJson['imageUrl'],
            videoUrl: articleJson['videoUrl'],
            audioUrl: articleJson['audioUrl'],
            publishDate: DateTime.parse(articleJson['publishDate']),
            author: articleJson['author'],
            tags: List<String>.from(articleJson['tags']),
          ),
        )
        .toList();
  }

  Future<Article?> getArticleById(String id) async {
    final articles = await getArticles();
    try {
      return articles.firstWhere((article) => article.id == id);
    } catch (e) {
      // If article not found, return null instead of throwing an exception
      return null;
    }
  }
}
