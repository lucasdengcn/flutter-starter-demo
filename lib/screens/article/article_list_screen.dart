import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/article/viewmodel/article_viewmodel.dart';
import 'widgets/article_card.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articles'), centerTitle: true),
      body: Consumer<ArticleViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == ArticleViewState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.state == ArticleViewState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${viewModel.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.loadArticles(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (viewModel.articles.isEmpty) {
            return const Center(child: Text('No articles available'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: RefreshIndicator(
              onRefresh: () => viewModel.refreshArticles(),
              child: ListView.builder(
                controller: viewModel.scrollController,
                itemCount:
                    viewModel.articles.length +
                    (viewModel.state == ArticleViewState.loadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  // Show loading indicator at the bottom during pagination
                  if (index == viewModel.articles.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final article = viewModel.articles[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ArticleCard(
                      article: article,
                      onTap: () {
                        viewModel.selectArticle(article.id);
                        context.push('/article/detail/${article.id}');
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
