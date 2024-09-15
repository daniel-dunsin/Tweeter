import 'package:client/shared/constants/localstorage.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppModeBottomSheet extends StatelessWidget {
  const AppModeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final appCubit = context.read<AppCubit>();

    return Container(
      height: 250,
      width: double.maxFinite,
      padding: CustomTheme.majorScreenPadding,
      decoration: BoxDecoration(
        color: appColors.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Dark mode",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: appColors.foregroundColor,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dark Mode",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: appColors.secondaryForegroundColor,
                ),
              ),
              Switch.adaptive(
                value: !appCubit.state.isLightMode,
                onChanged: (value) {
                  appCubit.setAppMode(
                    context,
                    value ? AppBrightness.dark : AppBrightness.light,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                appCubit.setAppMode(
                  context,
                  AppBrightness.deviceSettings,
                );
              },
              child: Text(
                "Use device settings",
                style: TextStyle(
                  fontSize: 10.sp,
                  color: appColors.secondaryForegroundColor,
                  decoration: TextDecoration.underline,
                  decorationThickness: 3,
                  decorationColor: appColors.secondaryForegroundColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Set Dark mode to use the Light or Dark selection located in your device Display & Brightness settings",
              style: TextStyle(
                fontSize: 10.sp,
                color: appColors.secondaryForegroundColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
