part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class DeactivateAccountRequested extends SettingsEvent {}

class ChangePasswordRequested extends SettingsEvent {
  final ChangePasswordModel changePasswordModel;

  ChangePasswordRequested(this.changePasswordModel);
}

class SignOutRequested extends SettingsEvent {}

class UpdateUserNameRequested extends SettingsEvent {
  final String userName;

  UpdateUserNameRequested(this.userName);
}

class UpdateEmailRequested extends SettingsEvent {
  final String email;

  UpdateEmailRequested(this.email);
}

class VerifyPasswordRequested extends SettingsEvent {
  final String password;

  VerifyPasswordRequested(this.password);
}
