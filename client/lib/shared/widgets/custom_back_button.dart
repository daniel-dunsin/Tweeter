import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pop();
      },
      child: Icon(
        Icons.arrow_back,
        color: appColors.foregroundColor,
      ),
    );
  }
}
