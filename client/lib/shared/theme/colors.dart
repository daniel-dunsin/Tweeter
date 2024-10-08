import 'package:flutter/material.dart';

class TweeterColors extends ThemeExtension<TweeterColors> {
  static Color blue = const Color.fromRGBO(29, 161, 242, 1);
  static Color black = const Color.fromRGBO(7, 7, 7, 1);
  static Color darkGray = const Color.fromRGBO(60, 64, 72, 1);
  static Color lightGray = const Color.fromRGBO(170, 184, 194, 1);
  static Color extraLightGray = const Color.fromRGBO(216, 218, 219, 1);
  static Color white = const Color.fromRGBO(245, 248, 250, 1);

  final Color backgroundColor;
  final Color secondaryBackgroundColor;
  final Color inputBackgroundColor;
  final Color foregroundColor;
  final Color secondaryForegroundColor;
  final Color iconColor;

  const TweeterColors.internal({
    required this.backgroundColor,
    required this.secondaryBackgroundColor,
    required this.inputBackgroundColor,
    required this.foregroundColor,
    required this.secondaryForegroundColor,
    required this.iconColor,
  });

  factory TweeterColors.light() {
    return TweeterColors.internal(
      backgroundColor: white,
      secondaryBackgroundColor: extraLightGray,
      inputBackgroundColor: extraLightGray,
      foregroundColor: black,
      secondaryForegroundColor: darkGray,
      iconColor: blue,
    );
  }

  factory TweeterColors.dark() {
    return TweeterColors.internal(
      backgroundColor: black,
      inputBackgroundColor: darkGray,
      secondaryBackgroundColor: darkGray,
      foregroundColor: white,
      secondaryForegroundColor: extraLightGray,
      iconColor: blue,
    );
  }

  @override
  ThemeExtension<TweeterColors> copyWith({bool? lightMode}) {
    if (lightMode == null || lightMode == true) {
      return TweeterColors.light();
    }
    return TweeterColors.dark();
  }

  @override
  ThemeExtension<TweeterColors> lerp(covariant ThemeExtension<TweeterColors>? other, double t) {
    return this;
  }
}

extension ThemeDataExtended on ThemeData {
  TweeterColors get appColors => extension<TweeterColors>()!;
}
