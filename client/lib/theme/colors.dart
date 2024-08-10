import 'package:flutter/material.dart';

class TweeterColors extends ThemeExtension<TweeterColors> {
  static Color _blue = Color.fromRGBO(29, 161, 242, 1);
  static Color _black = Color.fromRGBO(20, 23, 26, 1);
  static Color _darkGray = Color.fromRGBO(109, 119, 134, 1);
  static Color _lightGray = Color.fromRGBO(170, 184, 194, 1);
  static Color _extraLightGray = Color.fromRGBO(225, 232, 237, 1);
  static Color _white = Color.fromRGBO(245, 248, 250, 1);

  final Color backgroundColor;
  final Color inputBackgroundColor;
  final Color foregroundColor;
  final Color secondaryForegroundColor;
  final Color iconColor;

  const TweeterColors._internal({
    required this.backgroundColor,
    required this.inputBackgroundColor,
    required this.foregroundColor,
    required this.secondaryForegroundColor,
    required this.iconColor,
  });

  factory TweeterColors.light() {
    return TweeterColors._internal(
      backgroundColor: _white,
      inputBackgroundColor: _lightGray,
      foregroundColor: _black,
      secondaryForegroundColor: _darkGray,
      iconColor: _blue,
    );
  }

  factory TweeterColors.dark() {
    return TweeterColors._internal(
      backgroundColor: _black,
      inputBackgroundColor: _darkGray,
      foregroundColor: _white,
      secondaryForegroundColor: _extraLightGray,
      iconColor: _blue,
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
