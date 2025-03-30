import 'package:flutter/material.dart';

import '../../../features/article/model/article_model.dart';

class ArticleHeaderWidget extends StatelessWidget {
  final Article article;

  const ArticleHeaderWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            article.publishDate.toString().split(' ')[0],
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(
                context,
              ).textTheme.bodySmall?.color?.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
