import 'package:client/config/routes.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class EnterForgotPasswordCodeScreen extends StatelessWidget {
  const EnterForgotPasswordCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? email = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?)?["email"];

    return AppCover(
      appBar: AppBar(
        leading: CancelAppbarLeading(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AuthRoutes.login,
              (route) => false,
            );
          },
        ),
        toolbarHeight: 30,
        leadingWidth: double.maxFinite,
      ),
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
            "Check your email ($email) to get your confirmation code. If you need to request a new code, go back and reselect a confirmation.",
            style: TextStyle(
              fontSize: 13,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).popAndPushNamed(AuthRoutes.forgotPassword);
                },
                child: const Text("Back"),
              ),
              ContainedButton(
                  child: Text("Next"),
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed(AuthRoutes.resetPassword);
                  })
            ],
          )
        ],
      ),
    );
  }
}
