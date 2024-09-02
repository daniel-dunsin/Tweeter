import 'package:client/config/routes.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/modules/auth/routes/select_sign_up/widgets/already_have_an_account.dart';
import 'package:client/modules/auth/routes/select_sign_up/widgets/google_button.dart';
import 'package:client/modules/auth/routes/select_sign_up/widgets/or_divider.dart';
import 'package:client/modules/auth/routes/select_sign_up/widgets/terms_and_condition.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/network.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSignUpScreen extends StatelessWidget {
  const SelectSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return AppCover(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              "See what's happening in the world right now.",
              style: TextStyle(
                color: appColors.foregroundColor,
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            const SizedBox(height: 20),
            GoogleButton(),
            SizedBox(height: 20),
            OrDivider(),
            SizedBox(height: 20),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthWithGoogleSuccess) {
                  handleSuccess("Welcome ${state.user.name}");
                  if (state.isNew) {
                    Navigator.pushNamed(context, AuthRoutes.updateDp);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context, PrivateRoutes.rootHome, (route) => false);
                  }
                }
              },
              builder: (context, state) {
                return ContainedButton(
                  child: Text(
                    "Create Account",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  fullWidth: true,
                  onPressed: () {
                    Navigator.of(context).pushNamed(AuthRoutes.signUp);
                  },
                  disabled: state is AuthWithGoogleLoading,
                );
              },
            ),
            SizedBox(height: 15),
            TermsAndCondition(),
            const SizedBox(height: 20),
            AlreadyHaveAnAccount(),
          ],
        ),
      ),
    );
  }
}
