part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class DeactivateAccountRequested extends SettingsEvent {}
