import 'package:client/modules/auth/routes/forgot_password/enter_forgot_password_code.dart';
import 'package:client/modules/auth/routes/forgot_password/forgot_password.dart';
import 'package:client/modules/auth/routes/forgot_password/reset_password.dart';
import 'package:client/modules/auth/routes/login/enter_login_password.dart';
import 'package:client/modules/auth/routes/login/login.dart';
import 'package:client/modules/auth/routes/select_sign_up/select_sign_up.dart';
import 'package:client/modules/auth/routes/onboarding/sign_up.dart';
import 'package:client/modules/auth/routes/onboarding/update_profile_picture.dart';
import 'package:client/modules/auth/routes/onboarding/verify_account.dart';
import 'package:client/modules/auth/routes/onboarding/select_interests.dart';
import 'package:client/modules/follow/routes/follows/follows.dart';
import 'package:client/modules/home/routes/root.dart';
import 'package:client/modules/profile/routes/user_profile/user_profile.dart';
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
  static String updateDp = "/auth/update-dp";
}

class PrivateRoutes {
  static String rootHome = "/private/root-home";
  static String profile = "/private/profile";
  static String follows = "/private/follows";
}

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
    AuthRoutes.updateDp: (context) => UpdateProfilePictureScreen(),

    // private
    PrivateRoutes.rootHome: (context) => RootHome(),
    PrivateRoutes.profile: (context) => UserProfileScreen(),
    PrivateRoutes.follows: (context) => FollowsScreen()
  };
}
