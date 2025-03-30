import 'package:flutter/material.dart';

class MarkdownRenderer extends StatelessWidget {
  final String content;

  const MarkdownRenderer({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paragraphs = content.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          paragraphs.map((paragraph) {
            // Handle headers
            if (paragraph.startsWith('# ')) {
              return Container(
                margin: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paragraph.substring(2),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                        height: 1.3,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 3,
                      width: 60,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              );
            } else if (paragraph.startsWith('## ')) {
              return Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 12.0),
                child: Text(
                  paragraph.substring(3),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor.withAlpha(229),
                    height: 1.3,
                    fontSize: 20.0,
                  ),
                ),
              );
            } else if (paragraph.startsWith('### ')) {
              return Container(
                margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Text(
                  paragraph.substring(4),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor.withAlpha(204),
                    height: 1.3,
                    fontSize: 18.0,
                  ),
                ),
              );
            } else if (paragraph.startsWith('- ')) {
              // Handle bullet points
              final bulletPoints = paragraph.split('\n- ');
              return Container(
                margin: const EdgeInsets.only(bottom: 16.0, left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      bulletPoints.map((point) {
                        String bulletText = point;
                        if (bulletPoints.indexOf(point) == 0) {
                          bulletText = point.substring(
                            2,
                          ); // Remove the initial '- '
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                height: 6,
                                width: 6,
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  bulletText,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    height: 1.5,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              );
            } else if (paragraph.startsWith('**') && paragraph.endsWith('**')) {
              // Handle bold text
              return Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withAlpha(13),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.primaryColor.withAlpha(26)),
                ),
                child: Text(
                  paragraph.substring(2, paragraph.length - 2),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    fontSize: 16.0,
                  ),
                ),
              );
            }
            // Handle regular paragraphs
            return Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                paragraph,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  letterSpacing: 0.3,
                  fontSize: 16.0,
                ),
              ),
            );
          }).toList(),
    );
  }
}
