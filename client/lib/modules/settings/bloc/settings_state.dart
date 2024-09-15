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
