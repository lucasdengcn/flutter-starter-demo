import 'package:flutter/material.dart';

import 'article_audio_widget.dart';
import 'article_video_widget.dart';

class ArticleMediaWidget extends StatelessWidget {
  final String? videoUrl;
  final String? audioUrl;

  const ArticleMediaWidget({super.key, this.videoUrl, this.audioUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (videoUrl != null) ...[
            ArticleVideoWidget(videoUrl: videoUrl!),
            const SizedBox(height: 24),
          ],
          if (audioUrl != null) ...[
            ArticleAudioWidget(audioUrl: audioUrl!),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
