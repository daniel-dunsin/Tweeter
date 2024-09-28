part of 'tweets_bloc.dart';

@immutable
sealed class TweetsState {}

class TweetsInitialState extends TweetsState {}

class GetUserTweetsLoading extends TweetsState {}

class GetUserTweetsError extends TweetsState {}

class GetUserTweetsSuccessful extends TweetsState {
  final List<TweetListModel> posts;
  final List<TweetListModel> replies;
  final List<TweetListModel> media;
  final List<TweetListModel> likes;

  GetUserTweetsSuccessful({
    required this.posts,
    required this.replies,
    required this.media,
    required this.likes,
  });
}
