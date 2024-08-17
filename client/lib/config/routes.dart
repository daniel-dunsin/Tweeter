import 'package:client/modules/auth/routes/forgot_password/enter_forgot_password_code.dart';
import 'package:client/modules/auth/routes/forgot_password/forgot_password.dart';
import 'package:client/modules/auth/routes/forgot_password/reset_password.dart';
import 'package:client/modules/auth/routes/login/enter_login_password.dart';
import 'package:client/modules/auth/routes/login/login.dart';
import 'package:client/modules/auth/routes/select_sign_up/select_sign_up.dart';
import 'package:client/modules/auth/routes/sign_up/sign_up.dart';
import 'package:client/modules/auth/routes/sign_up/verify_account.dart';
import 'package:client/modules/categories/routes/select_interests/select_interests.dart';
import 'package:flutter/material.dart';

class PublicRoutes {}

class AuthRoutes {
  static String signUpInitial = "/auth/sign-up-initial";
  static String signUp = "/auth/sign-up";
  static String login = "/auth/login";
  static String loginPassword = "/auth/login-password";
  static String forgotPassword = "/auth/forgot-password";
  static String forgotPasswordCode = "/auth/forgot-password/code";
  static String resetPassword = "/auth/forgot-password/reset";
  static String verifyEmail = "/auth/verify-email";
  static String selectInterests = "/auth/select-interests";
}

class PrivateRoutes {}

Map<String, Widget Function(BuildContext context)> getRoutes(BuildContext context) {
  return {
    AuthRoutes.signUpInitial: (context) => SelectSignUpScreen(),
    AuthRoutes.signUp: (context) => SignUpScreen(),
    AuthRoutes.login: (context) => LoginScreen(),
    AuthRoutes.loginPassword: (context) => EnterLoginPasswordScreen(),
    AuthRoutes.forgotPassword: (context) => ForgotPasswordScreen(),
    AuthRoutes.forgotPasswordCode: (context) => EnterForgotPasswordCodeScreen(),
    AuthRoutes.resetPassword: (context) => ResetPasswordScreen(),
    AuthRoutes.verifyEmail: (context) => VerifyAccountScreen(),
    AuthRoutes.selectInterests: (context) => SelectInterestScreen(),
  };
}
