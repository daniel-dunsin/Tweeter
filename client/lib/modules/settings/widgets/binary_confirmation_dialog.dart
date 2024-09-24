import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BinaryConfirmationDialog extends StatelessWidget {
  final Function() onYes;
  final String message;
  final String? title;

  const BinaryConfirmationDialog({
    super.key,
    required this.onYes,
    this.message = "Are you sure?",
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return AlertDialog.adaptive(
      backgroundColor: appColors.backgroundColor,
      content: Text(message),
      title: title != null ? Text(title!) : null,
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            "No",
            style: TextStyle(
              color: Colors.blue[600],
              fontWeight: FontWeight.bold,
              fontSize: 12.h,
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
              fontSize: 12.h,
            ),
          ),
        )
      ],
    );
  }
}
