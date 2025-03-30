import 'package:flutter/material.dart';

import '../../../core/widgets/image_widget.dart';

class ArticleImageWidget extends StatelessWidget {
  final String imageUrl;

  const ArticleImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
              stops: const [0.7, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.darken,
          child: ImageWidget(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
