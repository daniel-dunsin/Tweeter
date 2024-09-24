import 'dart:io';

import 'package:client/modules/tweets/routes/create_tweet/bloc/create_tweet_bloc.dart';
import 'package:client/shared/constants/misc.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTweetFooter extends StatefulWidget {
  const CreateTweetFooter({super.key});

  @override
  State<CreateTweetFooter> createState() => _CreateTweetFooterState();
}

class _CreateTweetFooterState extends State<CreateTweetFooter> {
  void _addTweet() {
    context.read<CreateTweetBloc>().add(AddNewTweet());
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final createTweetState = context.watch<CreateTweetBloc>().state;

    final currentTweet = createTweetState.tweets[createTweetState.position];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIcon(
                  context: context,
                  enabled: true,
                  icon: Icons.voice_chat,
                ),
                _buildIcon(
                  context: context,
                  enabled: true,
                  icon: Icons.photo_outlined,
                  onTap: () async {
                    final File? image = await pickImage();

                    if (image != null) {
                      context.read<CreateTweetBloc>().add(AddImage(image));
                    }
                  },
                ),
                _buildIcon(
                  context: context,
                  enabled: true,
                  icon: Icons.gif_box_outlined,
                ),
                _buildIcon(
                  context: context,
                  enabled: true,
                  icon: Icons.location_pin,
                ),
              ],
            ),
          ),
          const Spacer(flex: 1),
          SizedBox(
            width: 13.5.h,
            height: 13.5.h,
            child: CircularProgressIndicator(
              value: (currentTweet.text?.length ?? 0) / maxCharacterCount,
              valueColor: AlwaysStoppedAnimation<Color>(
                currentTweet.text != null ? appColors.iconColor : appColors.secondaryBackgroundColor,
              ),
              backgroundColor: appColors.secondaryBackgroundColor,
              strokeWidth: 1,
            ),
          ),
          const SizedBox(width: 20),
          Container(
            width: 1,
            height: 20,
            color: Colors.grey,
          ),
          const SizedBox(width: 20),
          _buildIcon(
            context: context,
            enabled: true,
            icon: Icons.add_circle,
            onTap: _addTweet,
          ),
        ],
      ),
    );
  }

  Widget _buildIcon({
    required BuildContext context,
    required IconData icon,
    required bool enabled,
    GestureTapCallback? onTap,
  }) {
    final appColors = Theme.of(context).appColors;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Icon(
        icon,
        color: enabled ? appColors.iconColor : const Color.fromARGB(120, 29, 160, 242),
        size: 18.h,
      ),
    );
  }
}
