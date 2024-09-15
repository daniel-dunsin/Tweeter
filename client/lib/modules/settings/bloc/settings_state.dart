part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

class SettingsInitialState extends SettingsState {}

class DeactivateAccountLoading extends SettingsState {}

class DeactivateAccountSuccessful extends SettingsState {}

class DeactivateAccountError extends SettingsState {}
