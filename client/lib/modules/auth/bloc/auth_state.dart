import 'package:flutter/foundation.dart';

@immutable
sealed class AuthState {}

class AuthInitialState extends AuthState {}

class AuthSignUpLoading extends AuthState {}

class AuthSignUpSuccess extends AuthState {}

class AuthSignUpError extends AuthState {}
