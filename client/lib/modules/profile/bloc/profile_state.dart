part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

class ProfileInitialState extends ProfileState {}

class GetProfileLoading extends ProfileState {}

class GetProfileSuccess extends ProfileState {
  final UserModel user;

  GetProfileSuccess(this.user);
}

class GetProfileError extends ProfileState {}

class EditProfileLoading extends ProfileState {}

class EditProfileSuccess extends ProfileState {
  final UserModel user;

  EditProfileSuccess(this.user);
}

class EditProfileError extends ProfileState {}

class DeleteProfilePictureLoading extends ProfileState {}

class DeleteProfilePictureSuccess extends ProfileState {}

class DeleteProfilePictureError extends ProfileState {}

class DeleteCoverPictureLoading extends ProfileState {}

class DeleteCoverPictureSuccess extends ProfileState {}

class DeleteCoverPictureError extends ProfileState {}
