part of 'follows_bloc.dart';

@immutable
sealed class FollowsState {}

class FollowsInitialState extends FollowsState {}

class GetUserFollowsLoading extends FollowsState {}

class GetUserFollowsSuccess extends FollowsState {
  final UserFollowsModel userFollows;

  GetUserFollowsSuccess(this.userFollows);
}

class GetUserFollowsError extends FollowsState {}
