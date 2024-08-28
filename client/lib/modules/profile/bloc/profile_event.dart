part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {}

class GetProfileRequested extends ProfileEvent {
  final String userId;

  GetProfileRequested(this.userId);
}

class EditProfileRequested extends ProfileEvent {
  final EditProfileModel editProfileDto;

  EditProfileRequested(this.editProfileDto);
}
