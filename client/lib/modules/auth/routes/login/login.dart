import 'package:client/config/routes.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/custom_app_bar.dart';
import 'package:client/shared/widgets/text_fields.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter/material.dart';

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
      appBar: customAppBar,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthCheckCredentialSuccess) {
            if (state.accountExists == true) {
              Navigator.of(context).pushNamed(
                AuthRoutes.loginPassword,
                arguments: {
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
              AnimatedOpacity(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Text("This account does not exist"),
                ),
                opacity: state is AuthCheckCredentialSuccess && state.accountExists == false ? 1 : 0,
                duration: const Duration(milliseconds: 500),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AuthRoutes.forgotPassword);
                      },
                      child: Text("Forgot Password?")),
                  ContainedButton(
                    disabled: credentialsController.text.isEmpty,
                    child: Text("Next"),
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
