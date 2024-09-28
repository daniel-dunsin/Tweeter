import 'package:client/modules/tweets/models/tweet_list_model.dart';
import 'package:client/modules/tweets/repository/tweet_repository.dart';
import 'package:client/shared/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tweets_event.dart';
part 'tweets_state.dart';

class TweetsBloc extends Bloc<TweetsEvent, TweetsState> {
  final TweetRepository tweetRepository;

  TweetsBloc({required this.tweetRepository}) : super(TweetsInitialState()) {
    on<GetUserTweetsRequested>(
      (event, emit) async {
        emit(GetUserTweetsLoading());

        try {
          final response = await tweetRepository.getUserTweets(event.userId);
          final Map data = response["data"];

          final List<TweetListModel> posts = (data["posts"] as List<dynamic>).map((tweet) => TweetListModel.fromMap(tweet)).toList();
          final List<TweetListModel> replies = (data["replies"] as List<dynamic>).map((tweet) => TweetListModel.fromMap(tweet)).toList();
          final List<TweetListModel> media = (data["media"] as List<dynamic>).map((tweet) => TweetListModel.fromMap(tweet)).toList();
          final List<TweetListModel> likes = (data["likes"] as List<dynamic>).map((tweet) => TweetListModel.fromMap(tweet)).toList();

          emit(
            GetUserTweetsSuccessful(
              posts: posts,
              replies: replies,
              media: media,
              likes: likes,
            ),
          );
        } catch (e) {
          emit(GetUserTweetsError());
          handleError(e: e);
        }
      },
    );
  }
}
