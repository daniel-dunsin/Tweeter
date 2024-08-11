import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      runAlignment: WrapAlignment.start,
      children: [
        Text(
          "By signing up, you agree to our ",
          style: TextStyle(
            fontSize: 11,
            color: appColors.secondaryForegroundColor,
          ),
        ),
        Text(
          "terms, ",
          style: TextStyle(
            fontSize: 11,
            color: appColors.iconColor,
          ),
        ),
        Text(
          "privacy policy ",
          style: TextStyle(
            fontSize: 11,
            color: appColors.iconColor,
          ),
        ),
        Text(
          "and ",
          style: TextStyle(
            fontSize: 11,
            color: appColors.secondaryForegroundColor,
          ),
        ),
        Text(
          "cookie use",
          style: TextStyle(
            fontSize: 11,
            color: appColors.iconColor,
          ),
        )
      ],
    );
  }
}
