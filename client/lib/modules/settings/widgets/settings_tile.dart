import 'package:client/modules/settings/models/settings_tile_model.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SettingsTile extends StatelessWidget {
  final SettingsTileModel tileModel;

  const SettingsTile({super.key, required this.tileModel});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: tileModel.route != null ? () => GoRouter.of(context).pushNamed(tileModel.route!) : null,
        leading: Icon(
          tileModel.icon,
          color: appColors.secondaryForegroundColor,
          size: 20.sp,
        ),
        title: Text(tileModel.title),
        titleTextStyle: TextStyle(
          color: appColors.secondaryForegroundColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
        subtitle: Text(tileModel.description),
        subtitleTextStyle: TextStyle(
          color: Colors.grey,
          fontSize: 10.sp,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          size: 14.sp,
        ),
      ),
    );
  }
}
