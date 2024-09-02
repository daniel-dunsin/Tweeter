import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/index.dart';
import 'package:flutter/material.dart';

class NoFollower extends StatelessWidget {
  const NoFollower({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return Padding(
      padding: CustomTheme.majorScreenPadding,
      child: Center(
        child: Text(
          "When someone follows you, they’ll show up here.",
          style: TextStyle(
            color: appColors.foregroundColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
