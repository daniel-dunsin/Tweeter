import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class NoFollower extends StatelessWidget {
  const NoFollower({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return Center(
      child: Text(
        "When someone follows, they’ll show up here.",
        style: TextStyle(
          color: appColors.foregroundColor,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
