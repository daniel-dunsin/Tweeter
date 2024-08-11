import 'package:client/modules/auth/models/user_model.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AuthState {}

class AuthInitialState extends AuthState {}

class AuthSignUpLoading extends AuthState {}

class AuthSignUpSuccess extends AuthState {}

class AuthSignUpError extends AuthState {}

class AuthVerifyEmailLoading extends AuthState {}

class AuthVerifyEmailSuccess extends AuthState {
  final UserModel user;

  AuthVerifyEmailSuccess({required this.user});
}

class AuthVerifyEmailError extends AuthState {}
