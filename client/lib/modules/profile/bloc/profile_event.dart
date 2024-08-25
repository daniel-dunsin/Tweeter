part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {}

class GetProfileRequested extends ProfileEvent {
  final String userId;

  GetProfileRequested(this.userId);
}
