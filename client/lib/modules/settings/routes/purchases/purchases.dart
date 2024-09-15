import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/utils/misc.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return AppCover(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: const CustomBackButton(),
        title: const Text("Purchases"),
        titleTextStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: appColors.foregroundColor),
        shape: const Border(bottom: BorderSide(width: .6, color: Colors.grey)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My purchases",
            style: TextStyle(
              color: appColors.foregroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Legal",
            style: TextStyle(
              color: appColors.foregroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
          const SizedBox(height: 5),
          ListTile(
            onTap: () {
              openUrl("https://legal.x.com/purchaser-terms");
            },
            title: Text(
              "X Purchaser Terms",
              style: TextStyle(
                color: appColors.foregroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              size: 10.sp,
              color: appColors.foregroundColor,
            ),
            contentPadding: const EdgeInsets.all(0),
            minTileHeight: double.minPositive,
          )
        ],
      ),
    );
  }
}
