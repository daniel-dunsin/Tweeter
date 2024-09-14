import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final credentialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    credentialController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    credentialController.dispose();
  }

  void handleSubmit() {
    context.read<AuthBloc>().add(ForgotPasswordRequested(credentialController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CancelAppbarLeading(),
        leadingWidth: double.maxFinite,
      ),
      body: Padding(
        padding: CustomTheme.majorScreenPadding,
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            GoRouter.of(context).pushNamed(AuthRoutes.forgotPasswordCode);
          }
        }, builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Find your Tweeter account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter the email, or username associated with your account to change your password",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              UnderlinedTextField(
                fullWidth: true,
                labelText: "Email, or username",
                controller: credentialController,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: ContainedButton(
                  disabled: credentialController.text.isEmpty,
                  child: const Text("Next"),
                  loading: state is ForgotPasswordLoading,
                  onPressed: () {
                    handleSubmit();
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
