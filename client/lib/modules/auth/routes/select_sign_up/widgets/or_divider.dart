import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 2,
            thickness: .5,
            color: appColors.foregroundColor,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          "or",
          style: TextStyle(
            fontSize: 11,
            color: appColors.secondaryForegroundColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Divider(
            height: 2,
            thickness: 0.5,
            color: appColors.secondaryForegroundColor,
          ),
        ),
      ],
    );
  }
}
