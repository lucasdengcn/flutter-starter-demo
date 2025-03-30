import 'package:flutter/material.dart';

class ArticleHeaderWidget extends StatelessWidget {
  final String title;

  const ArticleHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: 1.0,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          height: 1.3,
        ),
      ),
    );
  }
}
