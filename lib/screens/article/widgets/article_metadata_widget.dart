import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleMetadataWidget extends StatelessWidget {
  final String author;
  final DateTime publishDate;
  final List<String> tags;

  const ArticleMetadataWidget({
    super.key,
    required this.author,
    required this.publishDate,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Author and Date
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: theme.primaryColor.withOpacity(0.1),
                child: Icon(Icons.person, size: 16, color: theme.primaryColor),
              ),
              const SizedBox(width: 8),
              Text(
                author,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 14,
                backgroundColor: theme.primaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                DateFormat('MMM d, yyyy').format(publishDate),
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Tags
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              tags
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
