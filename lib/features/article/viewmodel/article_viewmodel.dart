import 'package:flutter/material.dart';

import '../../../core/viewmodel/base_viewmodel.dart';
import '../model/article_model.dart';
import '../service/article_service.dart';

enum ArticleViewState {
  initial,
  loading,
  loaded,
  error,
  loadingMore,
  refreshing,
}

class ArticleViewModel extends BaseViewModel {
  final ArticleService _articleService;
  ArticleViewState _state = ArticleViewState.initial;
  List<Article> _articles = [];
  Article? _selectedArticle;

  // For infinite scrolling
  bool _hasMoreArticles = true;
  int _currentPage = 1;
  final int _articlesPerPage = 10;
  final ScrollController scrollController = ScrollController();

  ArticleViewModel({required ArticleService articleService})
    : _articleService = articleService {
    loadArticles();

    // Setup scroll listener for infinite scrolling
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.8 &&
        !scrollController.position.outOfRange) {
      if (_state != ArticleViewState.loadingMore && _hasMoreArticles) {
        loadMoreArticles();
      }
    }
  }

  // Getters
  ArticleViewState get state => _state;
  List<Article> get articles => _articles;
  Article? get selectedArticle => _selectedArticle;

  void _setState(ArticleViewState newState) {
    _state = newState;
    notifyListeners();
  }

  // Load initial articles
  Future<void> loadArticles() async {
    try {
      _setState(ArticleViewState.loading);
      _currentPage = 1;
      _articles = await _articleService.getArticles();
      _hasMoreArticles = _articles.length >= _articlesPerPage;
      _setState(ArticleViewState.loaded);
    } catch (e) {
      setError(e.toString());
      _setState(ArticleViewState.error);
    }
  }

  // Refresh articles
  Future<void> refreshArticles() async {
    try {
      _setState(ArticleViewState.refreshing);
      _currentPage = 1;
      final refreshedArticles = await _articleService.getArticles();
      _articles = refreshedArticles;
      _hasMoreArticles = refreshedArticles.length >= _articlesPerPage;
      _setState(ArticleViewState.loaded);
    } catch (e) {
      setError(e.toString());
      // Keep existing articles on refresh error
      _setState(ArticleViewState.loaded);
    }
  }

  // Load more articles for infinite scrolling
  Future<void> loadMoreArticles() async {
    if (!_hasMoreArticles || _state == ArticleViewState.loadingMore) {
      return;
    }

    try {
      _setState(ArticleViewState.loadingMore);
      _currentPage++;
      final moreArticles = await _articleService.getArticles();

      if (moreArticles.isEmpty) {
        _hasMoreArticles = false;
      } else {
        _articles.addAll(moreArticles);
        _hasMoreArticles = moreArticles.length >= _articlesPerPage;
      }

      _setState(ArticleViewState.loaded);
    } catch (e) {
      setError(e.toString());
      // Don't change state to error, just log the error and keep previous state
      _setState(ArticleViewState.loaded);
    }
  }

  // Select an article by ID
  Future<void> selectArticle(String id) async {
    try {
      _setState(ArticleViewState.loading);
      _selectedArticle = await _articleService.getArticleById(id);
      if (_selectedArticle == null) {
        setError('Article not found');
        _setState(ArticleViewState.error);
      } else {
        _setState(ArticleViewState.loaded);
      }
    } catch (e) {
      setError(e.toString());
      _setState(ArticleViewState.error);
    }
  }

  // Clear selected article
  void clearSelectedArticle() {
    _selectedArticle = null;
    notifyListeners();
  }
}
