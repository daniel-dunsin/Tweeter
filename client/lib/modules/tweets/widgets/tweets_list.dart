import 'package:client/modules/tweets/models/tweet_list_model.dart';
import 'package:client/modules/tweets/widgets/single_tweet.dart';
import 'package:client/modules/tweets/widgets/tweet_shimmer.dart';
import 'package:flutter/material.dart';

class TweetsList extends StatelessWidget {
  final bool loading;
  final List<TweetListModel> tweets;

  const TweetsList({
    super.key,
    required this.tweets,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return loading
        ? const SingleChildScrollView(
            child: Column(
              children: [
                TweetShimmer(),
                TweetShimmer(),
                TweetShimmer(),
                TweetShimmer(),
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return SingleTweet(
                tweet: tweets[index],
              );
            },
            itemCount: tweets.length,
          );
  }
}
