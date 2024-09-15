import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/settings/widgets/account_info_tile.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

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
              "Account",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: appColors.foregroundColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "@${user.userName}",
              style: TextStyle(
                fontSize: 10.sp,
                color: appColors.secondaryForegroundColor,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccountInfoTile(
                  tileKey: "Username",
                  tileValue: "${user.userName}",
                  tileNextScreen: PrivateRoutes.updateUserName,
                ),
                AccountInfoTile(
                  tileKey: "Email",
                  tileValue: "${user.email}",
                  tileNextScreen: PrivateRoutes.updateEmail,
                  nextScreenNeedsGuard: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
