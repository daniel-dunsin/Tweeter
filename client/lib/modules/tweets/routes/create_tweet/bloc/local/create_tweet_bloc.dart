import 'dart:io';

import 'package:client/modules/tweets/enums/index.dart';
import 'package:client/modules/tweets/routes/create_tweet/models/create_tweet_media_model.dart';
import 'package:client/modules/tweets/routes/create_tweet/models/create_tweet_model.dart';
import 'package:client/modules/tweets/routes/create_tweet/models/single_create_tweet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_tweet_event.dart';

class CreateTweetBloc extends Bloc<CreateTweetEvent, CreateTweetModel> {
  CreateTweetBloc()
      : super(
          CreateTweetModel(
            tweets: [
              SingleCreateTweetModel(),
            ],
          ),
        ) {
    on<AddNewTweet>(
      (event, emit) {
        final List<SingleCreateTweetModel> tweets = List.from(state.tweets);

        tweets.add(SingleCreateTweetModel());
        emit(state.copyWith(tweets: tweets, position: state.position + 1));
      },
    );

    on<AddText>(
      (event, emit) {
        final List<SingleCreateTweetModel> tweets = List.from(state.tweets);
        tweets[state.position].text = event.text;

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<AddAudio>(
      (event, emit) {
        final List<SingleCreateTweetModel> tweets = List.from(state.tweets);

        final updatedTweet = tweets[state.position].copyWith(
          media: [
            ...tweets[state.position].media,
            CreateTweetMediaModel(
              type: TweetMediaType.audio,
              file: event.audio,
            ),
          ],
        );

        tweets[state.position] = updatedTweet;

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<AddVideo>(
      (event, emit) {
        final List<SingleCreateTweetModel> tweets = List.from(state.tweets);

        final updatedTweet = tweets[state.position].copyWith(
          media: [
            ...tweets[state.position].media,
            CreateTweetMediaModel(
              type: TweetMediaType.video,
              file: event.video,
            ),
          ],
        );

        tweets[state.position] = updatedTweet;

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<AddGif>(
      (event, emit) {
        final List<SingleCreateTweetModel> tweets = List.from(state.tweets);

        final updatedTweet = tweets[state.position].copyWith(
          media: [
            ...tweets[state.position].media,
            CreateTweetMediaModel(
              type: TweetMediaType.gif,
              url: event.gifUrl,
            ),
          ],
        );

        tweets[state.position] = updatedTweet;

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<AddImage>(
      (event, emit) {
        final List<SingleCreateTweetModel> tweets = List.from(state.tweets);

        final updatedTweet = tweets[state.position].copyWith(
          media: [
            ...tweets[state.position].media,
            CreateTweetMediaModel(
              type: TweetMediaType.image,
              file: event.image,
            ),
          ],
        );

        tweets[state.position] = updatedTweet;

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<RemoveMedia>(
      (event, emit) {
        final List<SingleCreateTweetModel> tweets = List.from(state.tweets);

        tweets[state.position].media.removeAt(event.index);

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<RemoveTweet>(
      (event, emit) {
        final List<SingleCreateTweetModel> tweets = List.from(state.tweets);
        int newPosition;

        if (state.position == tweets.length - 1) {
          newPosition = state.position - 1;
        } else {
          newPosition = state.position;
        }

        if (tweets.length > 1) {
          tweets.removeLast();
        }

        emit(state.copyWith(tweets: tweets, position: newPosition));
      },
    );

    on<ChangeActiveIndex>((event, emit) {
      emit(state.copyWith(position: event.index));
    });

    on<ResetCreateTweet>((event, emit) {
      emit(CreateTweetModel(tweets: [
        SingleCreateTweetModel(),
      ], position: 0));
    });
  }
}
