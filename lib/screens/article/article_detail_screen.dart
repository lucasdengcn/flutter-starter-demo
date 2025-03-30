import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/article/viewmodel/article_viewmodel.dart';
import 'widgets/article_action_toolbar.dart';
import 'widgets/article_header_widget.dart';
import 'widgets/article_image_widget.dart';
import 'widgets/article_metadata_widget.dart';
import 'widgets/article_title_widget.dart';
import 'widgets/markdown_renderer.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Show title when scrolled down past a threshold (e.g., 100 pixels)
    if (_scrollController.offset > 100 && !_showTitle) {
      setState(() {
        _showTitle = true;
      });
    } else if (_scrollController.offset <= 100 && _showTitle) {
      setState(() {
        _showTitle = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(
      builder: (context, viewModel, child) {
        final article = viewModel.selectedArticle;

        if (viewModel.state == ArticleViewState.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (article == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Article not found')),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // App Bar with Image
              SliverAppBar(
                expandedHeight: 250.0,
                pinned: true,
                stretch: true,
                backgroundColor: Theme.of(context).primaryColor,
                elevation: _showTitle ? 4.0 : 0,
                shadowColor: Colors.black45,
                title: ArticleTitleWidget(
                  title: article.title,
                  showTitle: _showTitle,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  background: Hero(
                    tag: 'article-image-${article.id}',
                    child: ArticleImageWidget(imageUrl: article.imageUrl),
                  ),
                ),
              ),
              // Article Content
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Publish Date
                      ArticleHeaderWidget(article: article),
                      const SizedBox(height: 16),
                      // Author, Date and Tags
                      ArticleMetadataWidget(article: article),
                      const Divider(height: 32),
                      // Content
                      MarkdownRenderer(content: article.content),
                      const SizedBox(height: 24),
                      // Action Toolbar
                      ArticleActionToolbar(article: article),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
