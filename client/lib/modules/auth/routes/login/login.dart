import 'package:client/config/routes.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CancelAppbarLeading(),
        leadingWidth: double.maxFinite,
      ),
      body: Padding(
        padding: CustomTheme.majorScreenPadding,
        child: Column(
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
            const UnderlinedTextField(
              labelText: "Phone, email or username",
              fullWidth: true,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Forgot Password?"),
                ContainedButton(
                  child: Text("Next"),
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed(
                      AuthRoutes.loginPassword,
                      arguments: {"email": "adejaredaniel12@gmail.com"},
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
