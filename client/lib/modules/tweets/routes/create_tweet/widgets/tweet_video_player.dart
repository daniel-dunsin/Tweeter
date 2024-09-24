import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class EditableTweetVideoPlayer extends StatefulWidget {
  final File file;
  const EditableTweetVideoPlayer({super.key, required this.file});

  @override
  State<EditableTweetVideoPlayer> createState() => _EditableTweetVideoPlayerState();
}

class _EditableTweetVideoPlayerState extends State<EditableTweetVideoPlayer> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerController.value.isInitialized ? VideoPlayer(videoPlayerController) : const SizedBox.shrink();
  }
}
