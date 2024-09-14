import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:client/shared/widgets/error_badge.dart';
import 'package:client/shared/widgets/text_fields.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final credentialsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    credentialsController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return AppCover(
      appBar: AppBar(
        leading: CancelAppbarLeading(
          onTap: () {
            final navigator = GoRouter.of(context);

            navigator.canPop() ? navigator.pop() : navigator.replace(AuthRoutes.signUpInitial);
          },
        ),
        leadingWidth: double.maxFinite,
        toolbarHeight: 50,
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthCheckCredentialSuccess) {
            if (state.accountExists == true) {
              GoRouter.of(context).pushNamed(
                AuthRoutes.loginPassword,
                extra: {
                  "credential": credentialsController.text
                },
              );
            } else {}
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              const Text(
                "To get started, first enter your phone, email, or @username",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              UnderlinedTextField(
                labelText: "Phone, email or username",
                fullWidth: true,
                controller: credentialsController,
              ),
              ErrorBadge(
                isVisible: state is AuthCheckCredentialSuccess && state.accountExists == false,
                message: "This account does not exist",
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pushNamed(AuthRoutes.forgotPassword);
                    },
                    child: const Text("Forgot Password?"),
                  ),
                  ContainedButton(
                    disabled: credentialsController.text.isEmpty,
                    child: const Text("Next"),
                    loading: state is AuthCheckCredentialLoading,
                    onPressed: () async {
                      authBloc.add(CheckCredentialRequested(credentialsController.text));
                    },
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
