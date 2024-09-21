import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/settings/bloc/settings_bloc.dart';
import 'package:client/modules/settings/widgets/account_info_tile.dart';
import 'package:client/modules/settings/widgets/binary_confirmation_dialog.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/custom_app_bar.dart';
import 'package:client/shared/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppCubit>().state.user;
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
                fontSize: 14.h,
                fontWeight: FontWeight.bold,
                color: appColors.foregroundColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "@${user?.userName}",
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
        child: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (context, state) {
            if (state is SignOutSuccessful) {
              GoRouter.of(context).goNamed(AuthRoutes.login);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccountInfoTile(
                      tileKey: "Username",
                      tileValue: "${user?.userName}",
                      tileNextScreen: PrivateRoutes.updateUserName,
                      disabled: state is SignOutLoading,
                    ),
                    AccountInfoTile(
                      tileKey: "Email",
                      tileValue: "${user?.email}",
                      tileNextScreen: PrivateRoutes.updateEmail,
                      nextScreenNeedsGuard: true,
                      disabled: state is SignOutLoading,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Visibility(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => BinaryConfirmationDialog(
                                onYes: () {
                                  context.read<SettingsBloc>().add(SignOutRequested());
                                  context.pop();
                                },
                                message: "Are you sure you want to sign out?",
                              ),
                            );
                          },
                          child: Text(
                            "Log Out",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.h,
                            ),
                          ),
                        ),
                        visible: state is! SignOutLoading,
                        replacement: const TweeterLoader(),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
