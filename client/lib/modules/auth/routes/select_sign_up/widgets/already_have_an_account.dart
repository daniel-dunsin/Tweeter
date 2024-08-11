import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return Wrap(
      children: <Widget>[
        Text(
          "Already have an account? ",
          style: TextStyle(
            fontSize: 11,
            color: appColors.secondaryForegroundColor,
          ),
        ),
        Text(
          "Log in",
          style: TextStyle(
            fontSize: 11,
            color: appColors.iconColor,
          ),
        )
      ],
    );
  }
}
