import 'package:client/modules/settings/bloc/settings_bloc.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/logo.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class VerifyPassword extends StatefulWidget {
  final String nextRoute;

  const VerifyPassword({
    super.key,
    required this.nextRoute,
  });

  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  void submit() {
    context.read<SettingsBloc>().add(VerifyPasswordRequested(_passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        title: const Logo(),
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is VerifyPasswordSuccessful) {
            GoRouter.of(context).replace(widget.nextRoute);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: CustomTheme.majorScreenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verify your password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.h,
                      color: appColors.foregroundColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Re-enter your password to continue",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  UnderlinedPasswordTextField(
                    fullWidth: true,
                    labelText: "Password",
                    controller: _passwordController,
                  ),
                  const Spacer(),
                  ContainedButton(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.h,
                      ),
                    ),
                    onPressed: submit,
                    loading: state is VerifyPasswordLoading,
                    disabled: _passwordController.text.isEmpty,
                    fullWidth: true,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                      onTap: state is! VerifyPasswordSuccessful
                          ? () {
                              context.pop();
                            }
                          : null,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: appColors.foregroundColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationThickness: 3,
                          decorationColor: appColors.foregroundColor,
                          fontSize: 11.h,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
