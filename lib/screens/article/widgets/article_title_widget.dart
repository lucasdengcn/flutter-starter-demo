import 'package:flutter/material.dart';

class ArticleTitleWidget extends StatelessWidget {
  final String title;
  final bool showTitle;

  const ArticleTitleWidget({
    super.key,
    required this.title,
    required this.showTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child:
          showTitle
              ? Container(
                key: const ValueKey('title'),
                margin: const EdgeInsets.symmetric(horizontal: 1.0),
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 1.0,
                ),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              )
              : const SizedBox.shrink(),
    );
  }
}
