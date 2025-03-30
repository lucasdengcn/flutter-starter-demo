import 'package:flutter/material.dart';

import '../../../core/widgets/image_widget.dart';
import '../../../features/article/model/article_model.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          height: 280, // Fixed height for the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Article Image
              SizedBox(
                height: 160, // Fixed height for the image section
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background image
                    ImageWidget(imageUrl: article.imageUrl, fit: BoxFit.cover),
                  ],
                ),
              ),
              // Article Content
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.summary,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
