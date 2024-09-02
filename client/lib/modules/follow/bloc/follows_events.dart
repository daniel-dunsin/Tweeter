part of 'follows_bloc.dart';

@immutable
sealed class FollowsEvents {}

class GetUserFollowsRequested extends FollowsEvents {
  final String userId;

  GetUserFollowsRequested({required this.userId});
}

class GetSuggestedFollowsRequested extends FollowsEvents {}
