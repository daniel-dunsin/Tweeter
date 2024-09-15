import 'package:client/modules/settings/widgets/settings_tile.dart';
import 'package:client/shared/constants/settings_routes.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/custom_back_button.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppCubit>().state.user!;
    final appColors = Theme.of(context).appColors;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: .3, color: Colors.grey)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: appColors.foregroundColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "@${user.userName}",
                        style: TextStyle(fontSize: 10.sp, color: appColors.secondaryForegroundColor),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ContainedTextField(
                          fullWidth: true,
                          labelText: "Search Settings",
                          centerLabel: true,
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            color: appColors.secondaryForegroundColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Positioned(
                  child: SafeArea(
                    child: CustomBackButton(),
                  ),
                  top: 10,
                  left: 10,
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final model = settingsRoute[index];
                  return SettingsTile(tileModel: model);
                },
                itemCount: settingsRoute.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
