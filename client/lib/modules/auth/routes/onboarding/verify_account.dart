import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/modules/auth/models/verify_email_model.dart';
import 'package:client/shared/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifyAccountScreen extends StatefulWidget {
  final String email;

  const VerifyAccountScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  final codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    codeController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthVerifyEmailSuccess) {
          handleSuccess("Welcome ${state.user.name}");
          GoRouter.of(context).goNamed(AuthRoutes.updateDp);
        }
      },
      builder: (context, state) {
        return AppCover(
          appBar: AppBar(
            leading: CancelAppbarLeading(
              onTap: () {
                GoRouter.of(context).goNamed(AuthRoutes.signUp);
              },
            ),
            toolbarHeight: 30,
            leadingWidth: double.maxFinite,
          ),
          child: Column(
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
              Text(
                "Check your email (${widget.email}) to get your email verification code.",
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              UnderlinedTextField(
                labelText: "Enter your code",
                fullWidth: true,
                controller: codeController,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ContainedButton(
                    child: const Text("Next"),
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            VerifyEmailRequested(
                              VerifyEmailModel.fromMap(
                                {
                                  "code": codeController.text,
                                  "email": widget.email,
                                },
                              ),
                            ),
                          );
                    },
                    loading: state is AuthVerifyEmailLoading,
                    disabled: codeController.text.isEmpty,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
