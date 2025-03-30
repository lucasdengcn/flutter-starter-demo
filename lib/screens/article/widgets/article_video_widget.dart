import 'package:flutter/material.dart';

import '../../../core/widgets/video_player_widget.dart';

class ArticleVideoWidget extends StatelessWidget {
  final String videoUrl;

  const ArticleVideoWidget({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VideoPlayerWidget(videoUrl: videoUrl, autoPlay: false, looping: false),
        const SizedBox(height: 16),
      ],
    );
  }
}
