import 'package:client/modules/auth/routes/select_sign_up/widgets/already_have_an_account.dart';
import 'package:client/modules/auth/routes/select_sign_up/widgets/google_button.dart';
import 'package:client/modules/auth/routes/select_sign_up/widgets/or_divider.dart';
import 'package:client/modules/auth/routes/select_sign_up/widgets/terms_and_condition.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:flutter/material.dart';

class SelectSignUpScreen extends StatelessWidget {
  const SelectSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return Scaffold(
      body: Padding(
        padding: CustomTheme.majorScreenPadding,
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
              ContainedButton(
                child: Text(
                  "Create Account",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                fullWidth: true,
                onPressed: () {},
              ),
              SizedBox(height: 15),
              TermsAndCondition(),
              const SizedBox(height: 20),
              AlreadyHaveAnAccount(),
            ],
          ),
        ),
      ),
    );
  }
}
