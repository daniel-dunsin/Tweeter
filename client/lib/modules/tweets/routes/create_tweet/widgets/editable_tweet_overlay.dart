import 'package:client/modules/tweets/routes/create_tweet/bloc/local/create_tweet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditableTweetMediaOverlay extends StatefulWidget {
  final int mediaIndex;
  const EditableTweetMediaOverlay({super.key, required this.mediaIndex});

  @override
  State<EditableTweetMediaOverlay> createState() => _EditableTweetMediaOverlayState();
}

class _EditableTweetMediaOverlayState extends State<EditableTweetMediaOverlay> {
  void removeMedia() {
    context.read<CreateTweetBloc>().add(RemoveMedia(index: widget.mediaIndex));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: GestureDetector(
        onTap: removeMedia,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(0, 0, 0, 0.4),
                Color.fromRGBO(0, 0, 0, 0.4),
              ],
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Icon(
            Icons.close_rounded,
            color: Colors.white,
          ),
        ),
      ),
      width: 40,
      height: 40,
      top: 10,
      right: 10,
    );
  }
}
