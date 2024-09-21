import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/misc.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return AppCover(
      appBar: getMiscScreensAppBar(
        context,
        title: const Text("Purchases"),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My purchases",
            style: TextStyle(
              color: appColors.foregroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 13.h,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Legal",
            style: TextStyle(
              color: appColors.foregroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 13.h,
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
                fontSize: 10.h,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              size: 10.h,
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
