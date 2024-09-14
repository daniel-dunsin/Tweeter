import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/custom_app_bar.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EnterForgotPasswordCodeScreen extends StatefulWidget {
  const EnterForgotPasswordCodeScreen({super.key});

  @override
  State<EnterForgotPasswordCodeScreen> createState() => _EnterForgotPasswordCodeScreenState();
}

class _EnterForgotPasswordCodeScreenState extends State<EnterForgotPasswordCodeScreen> {
  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _codeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _codeController.dispose();
  }

  void handleSubmit() {
    context.read<AuthBloc>().add(ConfirmPasswordResetCodeRequested(_codeController.text));
  }

  @override
  Widget build(BuildContext context) {
    return AppCover(
      appBar: customAppBar,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ConfirmPasswordResetCodeSuccess) {
            GoRouter.of(context).replaceNamed(
              AuthRoutes.resetPassword,
              extra: {
                "code": _codeController.text
              },
            );
          }

          if (state is ConfirmPasswordResetCodeError) {
            _codeController.text = "";
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "We sent you a code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Check your email to get your confirmation code. If you need to request a new code, go back and reselect a confirmation.",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              UnderlinedTextField(
                labelText: "Enter your code",
                fullWidth: true,
                controller: _codeController,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text("Back"),
                  ),
                  ContainedButton(
                    child: const Text("Next"),
                    loading: state is ForgotPasswordLoading,
                    disabled: _codeController.text.isEmpty,
                    onPressed: () {
                      handleSubmit();
                    },
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
