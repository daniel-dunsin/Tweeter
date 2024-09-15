import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeactivateAccountScreen extends StatelessWidget {
  const DeactivateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppCubit>().state.user!;
    final appColors = Theme.of(context).appColors;

    return Scaffold(
      appBar: getMiscScreensAppBar(
        context,
        toolbarHeight: 60,
        title: Column(
          children: [
            Text(
              "Deactivate your account",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: appColors.foregroundColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "@${user.userName}",
              style: TextStyle(
                fontSize: 10.sp,
                color: appColors.secondaryForegroundColor,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePicture),
                  ),
                  title: Text(
                    "${user.name}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: appColors.foregroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "@${user.userName}",
                    style: TextStyle(
                      fontSize: 9.5.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "This will deactivate your account",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: appColors.foregroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "You’re about to start the process of deactivating your account. Your display name, @username, and public profile will no longer be viewable on x.com, X for iOS, or X for Android.",
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "What else you should know",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: appColors.foregroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\nYou can restore your X account if it was accidentally or wrongfully deactivated for up to 30 days after deactivation.\n\nIf you have any active paid subscriptions (e.g., Premium) purchased through the X app, they will remain active. You can manage these subscriptions through the platform where you originally subscribed. Subscriptions purchased on twitter.com will automatically cancel after you deactivate your account. \n\nSome account information may still be available in search engines, such as Google or Bing.\n\nIf you just want to change your @username, you don’t need to deactivate your account — edit it in your settings.\n\nTo use your current @username or email address with a different X account, change them before you deactivate this account.\n\nIf you want to download your X data, you’ll need to complete both the request and download process before deactivating your account. Links to download your data cannot be sent to deactivated accounts.",
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "Deactivate",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
