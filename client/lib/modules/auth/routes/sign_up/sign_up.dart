import 'package:client/config/routes.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:client/shared/widgets/date_selector.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Create your account",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            UnderlinedTextField(
              labelText: "Name",
              fullWidth: true,
            ),
            const SizedBox(height: 20),
            UnderlinedTextField(
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
              fullWidth: true,
            ),
            const SizedBox(height: 20),
            UnderlinedTextField(
              labelText: "Username",
              fullWidth: true,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return DateSelector();
                  },
                );
              },
              child: UnderlinedTextField(
                labelText: "Date Of Birth",
                enabled: false,
                fullWidth: true,
              ),
            ),
            const SizedBox(height: 20),
            const UnderlinedPasswordTextField(
              labelText: "Password",
              fullWidth: true,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ContainedButton(
                child: Text("Next"),
                onPressed: () {
                  Navigator.of(context).pushNamed(AuthRoutes.verifyEmail);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
