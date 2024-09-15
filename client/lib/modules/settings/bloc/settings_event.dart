part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class DeactivateAccountRequested extends SettingsEvent {}

class ChangePasswordRequested extends SettingsEvent {
  final ChangePasswordModel changePasswordModel;

  ChangePasswordRequested(this.changePasswordModel);
}

class SignOutRequested extends SettingsEvent {}
