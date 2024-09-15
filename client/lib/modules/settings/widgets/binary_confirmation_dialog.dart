import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BinaryConfirmationDialog extends StatelessWidget {
  final Function() onYes;
  final String message;

  const BinaryConfirmationDialog({super.key, required this.onYes, this.message = "Are you sure?"});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return AlertDialog.adaptive(
      backgroundColor: appColors.backgroundColor,
      title: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            "No",
            style: TextStyle(
              color: appColors.iconColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ),
        TextButton(
          onPressed: onYes,
          child: Text(
            "Yes",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        )
      ],
    );
  }
}
