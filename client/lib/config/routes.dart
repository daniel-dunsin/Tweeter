import 'package:flutter/material.dart';

class PublicRoutes {}

class AuthRoutes {
  static String signUpInitial = "signUpInitial";
}

class PrivateRoutes {}

Map<String, Widget Function(BuildContext context)> getRoutes(
    BuildContext context) {
  return {
    AuthRoutes.signUpInitial: (context) => Placeholder(),
  };
}
