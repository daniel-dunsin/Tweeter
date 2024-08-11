import 'package:client/shared/widgets/button.dart';
import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainedButton(
      fullWidth: true,
      icon: Image.asset(
        "assets/images/icons/google.png",
        width: 20,
        height: 20,
      ),
      child: Text(
        "Continue with google",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      onPressed: () {},
    );
  }
}
