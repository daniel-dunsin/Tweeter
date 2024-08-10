import 'package:flutter/material.dart';

class TweeterColors extends ThemeExtension<TweeterColors> {
  static Color blue = Color.fromRGBO(29, 161, 242, 1);
  static Color black = Color.fromRGBO(20, 23, 26, 1);
  static Color darkGray = Color.fromRGBO(109, 119, 134, 1);
  static Color lightGray = Color.fromRGBO(170, 184, 194, 1);
  static Color extraLightGray = Color.fromRGBO(225, 232, 237, 1);
  static Color white = Color.fromRGBO(245, 248, 250, 1);

  final Color backgroundColor;
  final Color inputBackgroundColor;
  final Color foregroundColor;
  final Color secondaryForegroundColor;
  final Color iconColor;

  const TweeterColors.internal({
    required this.backgroundColor,
    required this.inputBackgroundColor,
    required this.foregroundColor,
    required this.secondaryForegroundColor,
    required this.iconColor,
  });

  factory TweeterColors.light() {
    return TweeterColors.internal(
      backgroundColor: white,
      inputBackgroundColor: lightGray,
      foregroundColor: black,
      secondaryForegroundColor: darkGray,
      iconColor: blue,
    );
  }

  factory TweeterColors.dark() {
    return TweeterColors.internal(
      backgroundColor: black,
      inputBackgroundColor: darkGray,
      foregroundColor: white,
      secondaryForegroundColor: extraLightGray,
      iconColor: blue,
    );
  }

  ThemeExtension<TweeterColors> copyWith({bool? lightMode}) {
    if (lightMode == null || lightMode == true) {
      return TweeterColors.light();
    }
    return TweeterColors.dark();
  }

  @override
  ThemeExtension<TweeterColors> lerp(
      covariant ThemeExtension<TweeterColors>? other, double t) {
    return this;
  }
}

extension ThemeDataExtended on ThemeData {
  TweeterColors get appColors => extension<TweeterColors>()!;
}
