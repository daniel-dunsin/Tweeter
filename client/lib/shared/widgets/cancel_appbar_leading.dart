import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CancelAppbarLeading extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const CancelAppbarLeading({
    super.key,
    this.text = "Cancel",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 15),
      child: GestureDetector(
        onTap: () {
          onTap == null ? GoRouter.of(context).pop() : onTap!();
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class SkipAppBarAction extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const SkipAppBarAction({
    super.key,
    this.text = "Skip",
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return TextButton(
      child: Text(text),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
        foregroundColor: appColors.foregroundColor,
      ),
    );
  }
}
