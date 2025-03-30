import 'package:flutter/material.dart';

import '../../../core/widgets/audio_player_widget.dart';

class ArticleAudioWidget extends StatelessWidget {
  final String audioUrl;

  const ArticleAudioWidget({super.key, required this.audioUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AudioPlayerWidget(
          audioUrl: audioUrl,
          autoPlay: false,
          showProgress: true,
        ),
      ],
    );
  }
}
