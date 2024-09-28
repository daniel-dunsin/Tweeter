part of 'api_create_tweet_bloc.dart';

@immutable
sealed class ApiCreateTweetState {}

class ApiCreateTweetInitialState extends ApiCreateTweetState {}

class ApiCreateTweetLoading extends ApiCreateTweetState {}

class ApiCreateTweetSuccessful extends ApiCreateTweetState {}

class ApiCreateTweetError extends ApiCreateTweetState {}
