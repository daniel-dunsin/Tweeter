part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetProfileRequested extends ProfileEvent {
  final String userId;

  GetProfileRequested(this.userId);
}

class EditProfileRequested extends ProfileEvent {
  final EditProfileModel editProfileDto;

  EditProfileRequested(this.editProfileDto);
}

class DeleteCoverPictureRequested extends ProfileEvent {}

class DeleteProfilePictureRequested extends ProfileEvent {}
