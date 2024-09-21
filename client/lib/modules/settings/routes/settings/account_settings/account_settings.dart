import 'package:client/modules/settings/widgets/settings_tile.dart';
import 'package:client/shared/constants/settings_routes.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppCubit>().state.user!;
    final appColors = Theme.of(context).appColors;

    return Scaffold(
      appBar: getMiscScreensAppBar(
        context,
        toolbarHeight: 60,
        title: Column(
          children: [
            Text(
              "Your account",
              style: TextStyle(
                fontSize: 14.h,
                fontWeight: FontWeight.bold,
                color: appColors.foregroundColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "@${user.userName}",
              style: TextStyle(
                fontSize: 10.h,
                color: appColors.secondaryForegroundColor,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "See information about your account, download an archive of your data, or learn about your account deactivation options.",
                style: TextStyle(
                  fontSize: 10.h,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final model = accountSettingsRoutes[index];
                  return SettingsTile(tileModel: model);
                },
                itemCount: accountSettingsRoutes.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
