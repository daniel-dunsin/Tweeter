part of 'tweets_bloc.dart';

@immutable
sealed class TweetsEvent {}

class GetUserTweetsRequested extends TweetsEvent {
  final String userId;

  GetUserTweetsRequested(this.userId);
}
