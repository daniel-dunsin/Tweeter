import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class EnterLoginPasswordScreen extends StatelessWidget {
  const EnterLoginPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object?>?;
    final String? email = arguments?["email"] as String;

    return Scaffold(
      appBar: AppBar(
        leading: CancelAppbarLeading(),
        leadingWidth: double.maxFinite,
      ),
      body: Padding(
        padding: CustomTheme.majorScreenPadding,
        child: Column(
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
              initialValue: email,
              height: 45,
            ),
            const SizedBox(height: 20),
            UnderlinedPasswordTextField(
              fullWidth: true,
              labelText: "Password",
            ),
            Spacer(),
            ContainedButton(
              child: Text(
                "Log in",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {},
              fullWidth: true,
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationThickness: 2.5,
                  decorationColor: appColors.secondaryForegroundColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
