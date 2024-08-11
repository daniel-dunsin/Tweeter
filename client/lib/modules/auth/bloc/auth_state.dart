import 'package:flutter/foundation.dart';

@immutable
sealed class AuthState {}

class AuthInitialState extends AuthState {}

class AuthCheckingEmail extends AuthState {}

class AuthCheckEmailError extends AuthState {}

class AuthCheckEmailSuccess extends AuthState {}

class AuthCheckingUsername extends AuthState {}

class AuthCheckUsernameError extends AuthState {}

class AuthCheckUsernameSuccess extends AuthState {}
