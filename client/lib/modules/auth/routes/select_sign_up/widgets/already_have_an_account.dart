import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
            fontSize: 11.h,
            color: appColors.secondaryForegroundColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).pushNamed(AuthRoutes.login);
          },
          child: Text(
            "Log in",
            style: TextStyle(
              fontSize: 11.h,
              color: appColors.iconColor,
            ),
          ),
        )
      ],
    );
  }
}
