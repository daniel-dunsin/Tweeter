import 'package:client/modules/tweets/routes/create_tweet/create_tweet.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateTweetFloatingActionButton extends StatelessWidget {
  const CreateTweetFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => const CreateTweet(),
          enableDrag: false,
          useSafeArea: true,
          shape: const RoundedRectangleBorder(),
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          showDragHandle: false,
          useRootNavigator: true,
        );
      },
      tooltip: "Create Post",
      backgroundColor: appColors.iconColor,
      foregroundColor: Colors.white,
      child: Icon(
        Icons.add,
        size: 20.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
