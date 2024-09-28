import 'package:client/modules/tweets/enums/index.dart';
import 'package:client/modules/tweets/repository/tweet_repository.dart';
import 'package:client/modules/tweets/models/create_tweet_media_model.dart';
import 'package:client/modules/tweets/models/single_create_tweet_model.dart';
import 'package:client/shared/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'api_create_tweet_event.dart';
part 'api_create_tweet_state.dart';

class ApiCreateTweetBloc extends Bloc<ApiCreateTweetEvent, ApiCreateTweetState> {
  final TweetRepository tweetRepository;

  ApiCreateTweetBloc({required this.tweetRepository}) : super(ApiCreateTweetInitialState()) {
    on<ApiCreateTweetRequested>(
      (event, emit) async {
        emit(ApiCreateTweetLoading());
        try {
          List<SingleCreateTweetModel> tweets = event.tweets;

          tweets = await Future.wait(
            tweets.map(
              (tweet) async {
                if (tweet.media.isNotEmpty) {
                  for (int i = 0; i < tweet.media.length; i++) {
                    CreateTweetMediaModel media = tweet.media[i];
                    if (media.type != TweetMediaType.gif) {
                      final response = await tweetRepository.uploadMedia(media.file!);

                      final {
                        "public_id": publicId,
                        "secure_url": url
                      } = response;

                      media = media.copyWith(
                        url: url,
                        publicId: publicId,
                        file: null,
                        overrideFile: true,
                      );
                    }

                    tweet.media[i] = media;
                  }
                }

                return tweet;
              },
            ),
          );

          await tweetRepository.createTweet(tweets);

          emit(ApiCreateTweetSuccessful());
        } catch (e) {
          handleError(e: e);
          emit(ApiCreateTweetError());
        }
      },
    );
  }
}
