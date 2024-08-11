import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCover(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Choose a new password",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Make sure your new password is 8 characters or more. Try including numbers, letters, and punctuation marks for a strong password.",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "You'll be logged out of all active sessions after your password is changed.",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          UnderlinedPasswordTextField(labelText: "Enter a new password", fullWidth: true),
          const SizedBox(height: 10),
          UnderlinedPasswordTextField(
            labelText: "Confirm your new password",
            fullWidth: true,
          ),
          const Spacer(),
          ContainedButton(
            child: Text("Change Password"),
            fullWidth: true,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
