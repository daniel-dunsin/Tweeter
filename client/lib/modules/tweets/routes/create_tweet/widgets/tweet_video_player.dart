import 'dart:io';

import 'package:client/modules/tweets/routes/create_tweet/widgets/editable_tweet_overlay.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class EditableTweetVideoPlayer extends StatefulWidget {
  final int index;
  final File file;
  const EditableTweetVideoPlayer({
    super.key,
    required this.file,
    required this.index,
  });

  @override
  State<EditableTweetVideoPlayer> createState() => _EditableTweetVideoPlayerState();
}

class _EditableTweetVideoPlayerState extends State<EditableTweetVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
      });
    videoPlayerController.pause();
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerController.value.isInitialized
        ? Stack(
            children: [
              VideoPlayer(videoPlayerController),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.4),
                        Color.fromRGBO(0, 0, 0, 0.4),
                      ],
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (_isPlaying) {
                          await videoPlayerController.pause();
                        } else {
                          await videoPlayerController.play();
                        }

                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 0, 0, 0.4),
                              Color.fromRGBO(0, 0, 0, 0.4),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow_outlined, color: Colors.white),
                      ),
                    ),
                  ),
                  width: 300,
                  height: 300,
                ),
              ),
              EditableTweetMediaOverlay(mediaIndex: widget.index),
            ],
          )
        : const SizedBox.shrink();
  }
}
