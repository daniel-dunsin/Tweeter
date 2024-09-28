import 'package:client/modules/tweets/routes/create_tweet/bloc/api/api_create_tweet_bloc.dart';
import 'package:client/modules/tweets/routes/create_tweet/bloc/local/create_tweet_bloc.dart';
import 'package:client/modules/tweets/models/single_create_tweet_model.dart';
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

  bool validatePost(List<SingleCreateTweetModel> tweets) {
    bool disabled = false;

    tweets.forEach(
      (tweet) {
        final _disabled = ((tweet.text != null && tweet.text!.isEmpty) && tweet.media.length == 0);

        if (_disabled) {
          disabled = true;
        }
      },
    );

    return disabled;
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final createTweetBloc = context.watch<CreateTweetBloc>().state;

    bool postDisabled = validatePost(createTweetBloc.tweets);

    return Scaffold(
      appBar: AppBar(
        leading: CancelAppbarLeading(
          onTap: () {
            GoRouter.of(context).pop();
          },
        ),
        leadingWidth: 200,
        actions: [
          BlocConsumer<ApiCreateTweetBloc, ApiCreateTweetState>(
            listener: (context, state) {
              if (state is ApiCreateTweetSuccessful) {
                context.pop();
                context.read<CreateTweetBloc>().add(ResetCreateTweet());
              }
            },
            builder: (context, state) {
              return ContainedButton(
                child: Text(
                  "Post",
                  style: TextStyle(
                    fontSize: 11.h,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  context.read<ApiCreateTweetBloc>().add(ApiCreateTweetRequested(tweets: createTweetBloc.tweets));
                },
                disabled: postDisabled,
                loading: state is ApiCreateTweetLoading,
                backgroundColor: appColors.iconColor,
                foregroundColor: Colors.white,
                borderSide: BorderSide.none,
              );
            },
          ),
        ],
      ),
      body: Container(
        color: appColors.backgroundColor,
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => SingleCreateTweet(index: index),
                itemCount: createTweetBloc.tweets.length,
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
