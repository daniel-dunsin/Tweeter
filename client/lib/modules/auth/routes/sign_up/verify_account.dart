import 'package:client/config/routes.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? email = (ModalRoute.of(context)?.settings.arguments
        as Map<String, dynamic>?)?["email"];

    return Scaffold(
      appBar: AppBar(
        leading: CancelAppbarLeading(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AuthRoutes.signUp,
              (route) => false,
            );
          },
        ),
        leadingWidth: double.maxFinite,
      ),
      body: Padding(
        padding: CustomTheme.majorScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "We sent you a code",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Check your email ($email) to get your email verification code.",
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            UnderlinedTextField(
              labelText: "Enter your code",
              fullWidth: true,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ContainedButton(child: Text("Next"), onPressed: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}
