import 'package:flutter/foundation.dart';

@immutable
sealed class AuthEvent {}

class AuthInitialEvent extends AuthEvent {}

class AuthCheckEmail extends AuthEvent {}

class AuthCheckUserName extends AuthEvent {}

class AuthSignUp extends AuthEvent {}
