import 'package:client/modules/auth/models/sign_up_model.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AuthEvent {}

class AuthInitialEvent extends AuthEvent {}

class AuthSignUp extends AuthEvent {
  final SignUpModel signUpDto;

  AuthSignUp(this.signUpDto);
}
