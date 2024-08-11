import 'package:client/modules/auth/routes/login/enter_login_password.dart';
import 'package:client/modules/auth/routes/login/login.dart';
import 'package:client/modules/auth/routes/select_sign_up/select_sign_up.dart';
import 'package:client/modules/auth/routes/sign_up/sign_up.dart';
import 'package:flutter/material.dart';

class PublicRoutes {}

class AuthRoutes {
  static String signUpInitial = "/auth/sign-up-initial";
  static String signUp = "/auth/sign-up";
  static String login = "/auth/login";
  static String loginPassword = "/auth/login-password";
}

class PrivateRoutes {}

Map<String, Widget Function(BuildContext context)> getRoutes(
    BuildContext context) {
  return {
    AuthRoutes.signUpInitial: (context) => SelectSignUpScreen(),
    AuthRoutes.signUp: (context) => SignUpScreen(),
    AuthRoutes.login: (context) => LoginScreen(),
    AuthRoutes.loginPassword: (context) => EnterLoginPasswordScreen(),
  };
}
