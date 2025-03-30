import 'package:flutter/material.dart';

import '../../../features/article/model/article_model.dart';

class ArticleMetadataWidget extends StatelessWidget {
  final Article article;

  const ArticleMetadataWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Author and Date
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: theme.primaryColor.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    size: 16,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  article.author,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.favorite, size: 16, color: theme.primaryColor),
                const SizedBox(width: 6),
                Text(
                  '${article.likesCount}',
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
                ),
                const SizedBox(width: 12),
                Icon(Icons.thumb_up, size: 16, color: theme.primaryColor),
                const SizedBox(width: 6),
                Text(
                  '${article.thumbsUpCount}',
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        // Tags
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              article.tags
                  .map(
                    (tag) => Container(
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
