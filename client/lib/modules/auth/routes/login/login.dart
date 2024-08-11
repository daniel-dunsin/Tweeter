import 'package:client/config/routes.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCover(
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
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AuthRoutes.forgotPassword);
                  },
                  child: Text("Forgot Password?")),
              ContainedButton(
                child: Text("Next"),
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(
                    AuthRoutes.loginPassword,
                    arguments: {
                      "email": "adejaredaniel12@gmail.com"
                    },
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
