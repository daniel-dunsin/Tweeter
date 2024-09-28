import 'dart:io';

import 'package:client/modules/tweets/models/create_tweet_model.dart';
import 'package:client/modules/tweets/models/single_create_tweet_model.dart';
import 'package:client/modules/tweets/services/tweet_service.dart';

class TweetRepository {
  final TweetService tweetService;

  TweetRepository({required this.tweetService});

  uploadMedia(File file) async {
    final response = await tweetService.uploadMedia(file);

    return response.data;
  }

  createTweet(List<SingleCreateTweetModel> tweets) async {
    final response = await tweetService.createTweet(
      CreateTweetModel(tweets: tweets).toMap(),
    );

    return response;
  }

  getUserTweets(String userId) async {
    final response = await tweetService.getUserTweets(userId);

    return response.data;
  }

  getHomeTweets() async {
    final response = await tweetService.getHomeTweets();

    return response.data;
  }
}
