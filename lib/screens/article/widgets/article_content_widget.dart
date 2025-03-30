import 'package:flutter/material.dart';

class ArticleContentWidget extends StatelessWidget {
  final String content;

  const ArticleContentWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    // Simple markdown-like rendering
    final paragraphs = content.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          paragraphs.map((paragraph) {
            // Handle headers
            if (paragraph.startsWith('# ')) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Text(
                  paragraph.substring(2),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              );
            } else if (paragraph.startsWith('## ')) {
              return Padding(
                padding: const EdgeInsets.only(top: 14.0, bottom: 6.0),
                child: Text(
                  paragraph.substring(3),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            } else if (paragraph.startsWith('### ')) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
                child: Text(
                  paragraph.substring(4),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            }
            // Handle regular paragraphs
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                paragraph,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }).toList(),
    );
  }
}
