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

class AuthCheckCredentialLoading extends AuthState {}

class AuthCheckCredentialSuccess extends AuthState {
  final bool accountExists;

  AuthCheckCredentialSuccess({required this.accountExists});
}

class AuthCheckCredentialError extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final UserModel? user;
  final bool deactivated;
  final DateTime? deactivatedAt;

  LoginSuccess({required this.user, required this.deactivated, this.deactivatedAt});
}

class LoginError extends AuthState {}

class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {}

class ForgotPasswordError extends AuthState {}

class ConfirmPasswordResetCodeLoading extends AuthState {}

class ConfirmPasswordResetCodeSuccess extends AuthState {}

class ConfirmPasswordResetCodeError extends AuthState {}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class ResetPasswordError extends AuthState {}

class UpdateProfilePictureLoading extends AuthState {}

class UpdateProfilePictureSuccess extends AuthState {}

class UpdateProfilePictureError extends AuthState {}

class AuthWithGoogleLoading extends AuthState {}

class AuthWithGoogleSuccess extends AuthState {
  final UserModel? user;
  final bool isNew;
  final bool deactivated;
  final DateTime? deactivatedAt;

  AuthWithGoogleSuccess({
    this.user,
    required this.isNew,
    required this.deactivated,
    this.deactivatedAt,
  });
}

class AuthWithGoogleError extends AuthState {}

class ReActivateAccountLoading extends AuthState {}

class ReActivateAccountSuccess extends AuthState {
  final UserModel user;

  ReActivateAccountSuccess({required this.user});
}

class ReActivateAccountError extends AuthState {}
