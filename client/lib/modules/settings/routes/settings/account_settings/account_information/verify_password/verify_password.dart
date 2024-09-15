import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/logo.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class VerifyPassword extends StatelessWidget {
  final String nextRoute;

  const VerifyPassword({
    super.key,
    required this.nextRoute,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        title: const Logo(),
      ),
      body: SafeArea(
        child: Padding(
          padding: CustomTheme.majorScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verify your password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: appColors.foregroundColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Re-enter your password to continue",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              const UnderlinedPasswordTextField(
                fullWidth: true,
                labelText: "Password",
              ),
              const Spacer(),
              ContainedButton(
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
                onPressed: () {
                  GoRouter.of(context).replace(nextRoute);
                },
                fullWidth: true,
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: appColors.foregroundColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationThickness: 3,
                      decorationColor: appColors.foregroundColor,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
