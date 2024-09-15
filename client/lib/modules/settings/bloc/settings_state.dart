part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

class SettingsInitialState extends SettingsState {}

class DeactivateAccountLoading extends SettingsState {}

class DeactivateAccountSuccessful extends SettingsState {}

class DeactivateAccountError extends SettingsState {}

class ChangePasswordLoading extends SettingsState {}

class ChangePasswordSuccessful extends SettingsState {}

class ChangePasswordError extends SettingsState {}

class SignOutLoading extends SettingsState {}

class SignOutSuccessful extends SettingsState {}

class SignOutError extends SettingsState {}

class VerifyPasswordLoading extends SettingsState {}

class VerifyPasswordSuccessful extends SettingsState {}

class VerifyPasswordError extends SettingsState {}

class UpdateUsernameLoading extends SettingsState {}

class UpdateUsernameSuccessful extends SettingsState {}

class UpdateUsernameError extends SettingsState {}

class UpdateEmailLoading extends SettingsState {}

class UpdateEmailSuccessful extends SettingsState {}

class UpdateEmailError extends SettingsState {}
