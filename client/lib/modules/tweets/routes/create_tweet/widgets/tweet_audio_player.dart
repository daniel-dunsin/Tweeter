import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/misc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetAudioPlayer extends StatefulWidget {
  final File file;

  const TweetAudioPlayer({
    super.key,
    required this.file,
  });

  @override
  State<TweetAudioPlayer> createState() => _TweetAudioPlayerState();
}

class _TweetAudioPlayerState extends State<TweetAudioPlayer> {
  late AudioPlayer audioPlayer;
  Duration? duration;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await audioPlayer.setSourceDeviceFile(widget.file.path);
      await audioPlayer.resume();

      audioPlayer.getDuration().then((value) {
        setState(() {
          duration = value;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final user = context.watch<AppCubit>().state.user!;
    return Stack(
      children: [
        Container(
          color: appColors.iconColor,
          child: Center(
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.profilePicture),
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              if (_isPlaying) {
                audioPlayer.pause();
              } else {
                audioPlayer.resume();
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
        Positioned(
          child: Text(
            "${formatDuration(duration!)}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: 15,
          left: 15,
        ),
      ],
    );
  }
}
