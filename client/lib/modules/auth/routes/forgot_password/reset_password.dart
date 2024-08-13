import 'package:client/config/routes.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/modules/auth/models/reset_password_model.dart';
import 'package:client/shared/utils/network.dart';
import 'package:client/shared/utils/validators.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/custom_app_bar.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(() {
      setState(() {});
    });

    _confirmPasswordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void handleSubmit(String code) {
    context.read<AuthBloc>().add(
          ResetPasswordRequested(
            ResetPasswordModel(code: code, password: _passwordController.text),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> params = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final code = params["code"]!;

    return AppCover(
      appBar: customAppBar,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            handleSuccess("Password reset successful");
            Navigator.pushNamed(context, AuthRoutes.login);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Choose a new password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Make sure your new password is 8 characters or more. Try including numbers, letters, and punctuation marks for a strong password.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "You'll be logged out of all active sessions after your password is changed.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                UnderlinedPasswordTextField(
                  labelText: "Enter a new password",
                  fullWidth: true,
                  controller: _passwordController,
                  validator: passwordFieldValidator,
                ),
                const SizedBox(height: 10),
                UnderlinedPasswordTextField(
                  labelText: "Confirm your new password",
                  fullWidth: true,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }

                    if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }

                    return null;
                  },
                ),
                const Spacer(),
                ContainedButton(
                  child: Text("Change Password"),
                  fullWidth: true,
                  loading: state is ResetPasswordLoading,
                  disabled: _passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty,
                  onPressed: () {
                    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                      handleSubmit(code);
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
