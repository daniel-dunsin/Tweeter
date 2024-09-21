import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/profile/routes/edit_profile/widgets/profile_key_value.dart';
import 'package:client/modules/settings/bloc/settings_bloc.dart';
import 'package:client/modules/settings/models/change_password_model.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/network.dart';
import 'package:client/shared/utils/validators.dart';
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

  final _formKey = GlobalKey<FormState>();

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
  void dispose() {
    super.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    _formKey.currentState?.dispose();
  }

  void submit() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      context.read<SettingsBloc>().add(
            ChangePasswordRequested(
              ChangePasswordModel(
                newPassword: _newPasswordController.text,
                oldPassword: _currentPasswordController.text,
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppCubit>().state.user!;
    final appColors = Theme.of(context).appColors;

    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessful) {
          handleSuccess("Password changed successfully");
          context.pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: getMiscScreensAppBar(
            context,
            toolbarHeight: 60,
            title: Column(
              children: [
                Text(
                  "Update password",
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
            actions: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                  ),
                  child: GestureDetector(
                    onTap: state is ChangePasswordLoading ? null : submit,
                    child: Text(
                      state is ChangePasswordLoading ? "Saving..." : "Done",
                      style: TextStyle(
                        color: appColors.foregroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.h,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                      validator: passwordFieldValidator,
                      disableInput: state is ChangePasswordLoading,
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
                            fontSize: 10.5.h,
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
                      validator: passwordFieldValidator,
                      disableInput: state is ChangePasswordLoading,
                    ),
                    const Divider(height: 0.5, color: Colors.grey),
                    ProfileKeyValue(
                      profileKey: "Confirm Password",
                      controller: _confirmNewPasswordController,
                      enforceMinLine: true,
                      keyWidth: 140,
                      placeholder: "At least 8 characters",
                      obscureInput: true,
                      disableInput: state is ChangePasswordLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }

                        if (value.length < 8) {
                          return "Password must not be less than 8 characters";
                        }

                        if (value != _newPasswordController.text) {
                          return "Passwords do not match";
                        }

                        return null;
                      },
                    ),
                    const Divider(height: 0.5, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
