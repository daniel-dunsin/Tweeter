import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountInfoTile extends StatelessWidget {
  final String tileKey;
  final String tileValue;
  final String tileNextScreen;
  final bool nextScreenNeedsGuard;
  final bool disabled;

  const AccountInfoTile({
    super.key,
    required this.tileKey,
    required this.tileValue,
    required this.tileNextScreen,
    this.nextScreenNeedsGuard = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tileKey,
            style: TextStyle(
              color: appColors.foregroundColor,
              fontSize: 12.h,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (disabled) return;

              if (nextScreenNeedsGuard) {
                GoRouter.of(context).pushNamed(
                  PrivateRoutes.verifyPassword,
                  extra: {
                    "nextRoute": tileNextScreen,
                  },
                );
              } else {
                GoRouter.of(context).pushNamed(tileNextScreen);
              }
            },
            child: Row(
              children: [
                Text(
                  tileValue,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.h,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 13.h,
                  color: Colors.grey,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
