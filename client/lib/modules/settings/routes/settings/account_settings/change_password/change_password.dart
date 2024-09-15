import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/profile/routes/edit_profile/widgets/profile_key_value.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentPasswordController.addListener(() {
      setState(() {});
    });
    _newPasswordController.addListener(() {
      setState(() {});
    });
    _confirmNewPasswordController.addListener(() {
      setState(() {});
    });
  }

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
              "Update password",
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
        actions: [
          Visibility(
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                child: Text(
                  "Done",
                  style: TextStyle(
                    color: appColors.foregroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ),
            visible: _currentPasswordController.text.isNotEmpty && _newPasswordController.text.isNotEmpty && _confirmNewPasswordController.text.isNotEmpty,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileKeyValue(
                profileKey: "Current Password",
                controller: _currentPasswordController,
                enforceMinLine: true,
                keyWidth: 140,
                placeholder: "Enter current password",
                obscureInput: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed(AuthRoutes.forgotPassword);
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: appColors.iconColor,
                      fontSize: 10.5.sp,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(height: 0.5, color: Colors.grey),
              ProfileKeyValue(
                profileKey: "New Password",
                controller: _newPasswordController,
                enforceMinLine: true,
                keyWidth: 140,
                placeholder: "At least 8 characters",
                obscureInput: true,
              ),
              const Divider(height: 0.5, color: Colors.grey),
              ProfileKeyValue(
                profileKey: "Confirm Password",
                controller: _confirmNewPasswordController,
                enforceMinLine: true,
                keyWidth: 140,
                placeholder: "At least 8 characters",
                obscureInput: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
