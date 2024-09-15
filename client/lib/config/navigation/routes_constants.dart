import 'package:flutter/material.dart';

class PublicRoutes {}

class AuthRoutes {
  static String signUpInitial = "/auth";
  static String signUp = "/auth/sign_up";
  static String login = "/auth/sign_in";
  static String loginPassword = "/auth/sign_in_password";
  static String forgotPassword = "/auth/forgot_password";
  static String forgotPasswordCode = "/auth/forgot_password_code";
  static String resetPassword = "/auth/forgot_password_reset";
  static String verifyEmail = "/auth/verify_email";
  static String selectInterests = "/auth/select_interests";
  static String updateDp = "/auth/update_dp";
}

class PrivateRoutes {
  static String home = "/private/home";
  static String search = "/private/search";
  static String chat = "/private/chat";
  static String notifications = "/private/notification";
  static String communities = "/private/communities";
  static String profile = "/private/profile";
  static String follows = "/private/follows";
  static String purchases = "/private/purchases";

  static String settings = "/private/settings";
  static String accountSettings = "/private/settings/account";
  static String accountInformation = "/private/settings/account/information";
  static String changePassword = "/private/settings/account/change-password";
  static String deactivateAccount = "/private/settings/account/deactivate";
}

final GlobalKey<NavigatorState> appNavKey = GlobalKey<NavigatorState>();
