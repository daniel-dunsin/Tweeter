import 'dart:io';

import 'package:client/modules/tweets/enums/index.dart';
import 'package:client/modules/tweets/routes/create_tweet/models/create_tweet_location_model.dart';
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
        final tweets = state.tweets;

        tweets.add(SingleCreateTweetModel());
        emit(state.copyWith(tweets: tweets));
      },
    );

    on<AddText>(
      (event, emit) {
        final tweets = state.tweets;
        tweets[tweets.length - 1].text = event.text;

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<AddAudio>(
      (event, emit) {
        final tweets = state.tweets;

        tweets[tweets.length - 1].media.add(
              CreateTweetMediaModel(
                type: TweetMediaType.audio,
                file: event.audio,
              ),
            );

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<AddVideo>(
      (event, emit) {
        final tweets = state.tweets;

        tweets[tweets.length - 1].media.add(
              CreateTweetMediaModel(
                type: TweetMediaType.video,
                file: event.video,
              ),
            );

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<AddGif>(
      (event, emit) {
        final tweets = state.tweets;

        tweets[tweets.length - 1].media.add(
              CreateTweetMediaModel(
                type: TweetMediaType.gif,
                url: event.gifUrl,
              ),
            );

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<AddImage>(
      (event, emit) {
        final tweets = state.tweets;

        tweets[tweets.length - 1].media.add(
              CreateTweetMediaModel(
                type: TweetMediaType.image,
                file: event.image,
              ),
            );

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<RemoveMedia>(
      (event, emit) {
        final tweets = state.tweets;

        tweets[tweets.length - 1].media.removeAt(event.index);

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<RemoveTweet>(
      (event, emit) {
        final tweets = state.tweets;

        if (tweets.length > 1) {
          tweets.removeLast();
        }

        emit(state.copyWith(tweets: tweets));
      },
    );

    on<AddLocation>(
      (event, emit) {
        emit(state.copyWith(location: event.location));
      },
    );
  }
}
