part of 'api_create_tweet_bloc.dart';

@immutable
sealed class ApiCreateTweetEvent {}

class ApiCreateTweetRequested extends ApiCreateTweetEvent {
  final List<SingleCreateTweetModel> tweets;

  ApiCreateTweetRequested({required this.tweets});
}
