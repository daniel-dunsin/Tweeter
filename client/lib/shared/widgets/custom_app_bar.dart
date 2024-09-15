import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:client/shared/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final customAppBar = AppBar(
  leading: const CancelAppbarLeading(),
  leadingWidth: double.maxFinite,
  toolbarHeight: 30,
);

AppBar getMiscScreensAppBar(
  context, {
  final Widget? title,
  final Widget? leading,
  final List<Widget>? actions,
  final double toolbarHeight = 50,
}) {
  final appColors = Theme.of(context).appColors;

  return AppBar(
    leading: leading ?? const CustomBackButton(),
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: title,
    titleTextStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: appColors.foregroundColor),
    shape: const Border(bottom: BorderSide(width: .6, color: Colors.grey)),
    actions: actions,
    toolbarHeight: toolbarHeight,
  );
}
