import 'package:client/modules/tweets/routes/create_tweet/widgets/header.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateTweet extends StatelessWidget {
  const CreateTweet({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Scaffold(
      appBar: AppBar(
        leading: CancelAppbarLeading(
          onTap: () {
            GoRouter.of(context).pop();
          },
        ),
        leadingWidth: 200,
        actions: [
          ContainedButton(
            child: Text(
              "Post",
              style: TextStyle(
                fontSize: 11.h,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {},
            backgroundColor: appColors.iconColor,
            foregroundColor: Colors.white,
            borderSide: BorderSide.none,
          ),
        ],
      ),
      body: Container(
        color: appColors.backgroundColor,
        child: const Column(
          children: [
            CreateTweetHeader(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
