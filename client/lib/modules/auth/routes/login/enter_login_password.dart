import 'package:client/config/routes.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/modules/auth/models/login_model.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/utils/network.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterLoginPasswordScreen extends StatefulWidget {
  const EnterLoginPasswordScreen({super.key});

  @override
  State<EnterLoginPasswordScreen> createState() => _EnterLoginPasswordScreenState();
}

class _EnterLoginPasswordScreenState extends State<EnterLoginPasswordScreen> {
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      setState(() {});
    });
  }

  void handleSubmit(String credential) {
    context.read<AuthBloc>().add(LoginRequested(LoginModel(credential: credential, password: passwordController.text)));
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, Object?>?;
    final String? credential = arguments?["credential"] as String;

    return Scaffold(
      appBar: AppBar(
        leading: CancelAppbarLeading(),
        leadingWidth: double.maxFinite,
      ),
      body: Padding(
        padding: CustomTheme.majorScreenPadding,
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is LoginSuccess) {
            handleSuccess("Welcome ${state.user.name}");
            Navigator.pushNamedAndRemoveUntil(context, PrivateRoutes.rootHome, (route) => false);
          }
        }, builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your password",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              UnderlinedTextField(
                fullWidth: true,
                enabled: false,
                initialValue: credential,
                height: 45,
              ),
              const SizedBox(height: 20),
              UnderlinedPasswordTextField(
                fullWidth: true,
                labelText: "Password",
                controller: passwordController,
              ),
              const Spacer(),
              ContainedButton(
                child: Text(
                  "Log in",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                disabled: passwordController.text.isEmpty,
                onPressed: () {
                  handleSubmit(credential!);
                },
                loading: state is LoginLoading,
                fullWidth: true,
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AuthRoutes.forgotPassword);
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 2.5,
                      decorationColor: appColors.secondaryForegroundColor,
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
