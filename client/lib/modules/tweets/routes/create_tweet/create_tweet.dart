import 'package:client/modules/tweets/routes/create_tweet/bloc/create_tweet_bloc.dart';
import 'package:client/modules/tweets/routes/create_tweet/widgets/create_tweet_footer.dart';
import 'package:client/modules/tweets/routes/create_tweet/widgets/single_create_tweet.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTweet extends StatelessWidget {
  const CreateTweet({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final createTweetBloc = context.watch<CreateTweetBloc>().state;

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
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < createTweetBloc.tweets.length; i++) SingleCreateTweet(index: i),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Colors.grey,
              thickness: .5,
            ),
            const CreateTweetFooter(),
          ],
        ),
      ),
    );
  }
}
