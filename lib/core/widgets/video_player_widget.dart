import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.autoPlay = false,
    this.looping = false,
    this.aspectRatio = 16 / 9,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
      )..setLooping(widget.looping);

      await _videoPlayerController.initialize().timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw 'Connection timeout',
      );

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: widget.aspectRatio,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        allowedScreenSleep: false,
        showControlsOnInitialize: false,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: false,
        isLive: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.grey.withOpacity(0.5),
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              'Video Error: $errorMessage',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ),
        ),
        // Add these for playback timeout handling
        startAt: Duration.zero,
        customControls: const CupertinoControls(
          backgroundColor: Colors.black54,
          iconColor: Colors.white,
        ),
      );

      // Add timeout for video playback
      _videoPlayerController.addListener(() {
        if (!_videoPlayerController.value.isPlaying &&
            !_videoPlayerController.value.isBuffering &&
            !_videoPlayerController.value.isInitialized) {
          Future.delayed(const Duration(seconds: 15), () {
            if (!_videoPlayerController.value.isPlaying && mounted) {
              setState(() {
                _error = 'Video playback timed out';
              });
            }
          });
        }
      });

      setState(() => _isLoading = false);
    } on FormatException catch (_) {
      setState(() {
        _error = 'Invalid video URL format';
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load video: ${e.toString()}';
      });
    } finally {
      if (_error != null) {
        _videoPlayerController.dispose();
        _chewieController?.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _initializePlayer,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_chewieController != null) {
      return AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Chewie(controller: _chewieController!),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
