import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ContainedButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? icon;
  final Widget child;
  final bool? fullWidth;
  final double? width;
  final double? height;
  final bool? disabled;
  final bool? loading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderSide? borderSide;
  final double? elevation;

  ContainedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.width,
    this.height,
    this.fullWidth,
    this.icon,
    this.disabled,
    this.loading,
    this.backgroundColor,
    this.foregroundColor,
    this.borderSide,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return ElevatedButton.icon(
      onPressed: disabled == true || loading == true ? null : onPressed,
      label: loading == true ? LoadingAnimationWidget.discreteCircle(color: appColors.secondaryBackgroundColor, secondRingColor: appColors.secondaryBackgroundColor, thirdRingColor: appColors.secondaryBackgroundColor, size: 20) : child,
      icon: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? appColors.foregroundColor,
        overlayColor: backgroundColor ?? appColors.foregroundColor,
        foregroundColor: foregroundColor ?? appColors.secondaryBackgroundColor,
        iconColor: foregroundColor ?? appColors.secondaryBackgroundColor,
        disabledBackgroundColor: const Color.fromARGB(255, 100, 100, 100),
        disabledForegroundColor: const Color.fromARGB(255, 39, 38, 38),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        minimumSize: fullWidth == null && width == null && height == null
            ? null
            : fullWidth == true
                ? Size(double.maxFinite, height ?? 50)
                : Size(width ?? 200, height ?? 50),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            style: BorderStyle.solid,
            width: 2,
            color: disabled == true || loading == true ? Color.fromARGB(255, 100, 100, 100) : appColors.foregroundColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        elevation: elevation,
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? icon;
  final Widget child;
  final bool? fullWidth;
  final double? width;
  final double? height;
  final bool? disabled;
  final bool? loading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderSide? borderSide;
  final double? elevation;

  const SecondaryButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.width,
    this.height,
    this.fullWidth,
    this.icon,
    this.disabled,
    this.loading,
    this.backgroundColor,
    this.foregroundColor,
    this.borderSide,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return TextButton.icon(
      onPressed: disabled == true || loading == true ? null : onPressed,
      label: loading == true ? LoadingAnimationWidget.discreteCircle(color: appColors.secondaryBackgroundColor, secondRingColor: appColors.secondaryBackgroundColor, thirdRingColor: appColors.secondaryBackgroundColor, size: 20) : child,
      icon: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? appColors.backgroundColor,
        overlayColor: backgroundColor ?? appColors.backgroundColor,
        foregroundColor: foregroundColor ?? appColors.foregroundColor,
        iconColor: foregroundColor ?? appColors.foregroundColor,
        disabledBackgroundColor: const Color.fromARGB(255, 100, 100, 100),
        disabledForegroundColor: const Color.fromARGB(255, 39, 38, 38),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        minimumSize: fullWidth == null && width == null && height == null
            ? null
            : fullWidth == true
                ? Size(double.maxFinite, height ?? 50)
                : Size(width ?? 200, height ?? 50),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            style: BorderStyle.solid,
            width: 2,
            color: disabled == true || loading == true ? Color.fromARGB(255, 100, 100, 100) : appColors.foregroundColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        elevation: elevation,
      ),
    );
  }
}
