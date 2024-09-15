import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/custom_app_bar.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateUsernameScreen extends StatefulWidget {
  const UpdateUsernameScreen({super.key});

  @override
  State<UpdateUsernameScreen> createState() => _UpdateUsernameScreenState();
}

class _UpdateUsernameScreenState extends State<UpdateUsernameScreen> {
  final _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppCubit>().state.user!;
    final appColors = Theme.of(context).appColors;

    return Scaffold(
      appBar: getMiscScreensAppBar(
        context,
        toolbarHeight: 60,
        title: Text(
          "Update username",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: appColors.foregroundColor,
          ),
        ),
        actions: [
          Visibility(
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                child: Text(
                  "Done",
                  style: TextStyle(
                    color: appColors.foregroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ),
            visible: _userNameController.text.isNotEmpty,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current",
              style: TextStyle(
                color: appColors.foregroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 11.5.sp,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${user.userName}",
              style: TextStyle(
                color: appColors.foregroundColor,
                fontSize: 11.sp,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "New",
              style: TextStyle(
                color: appColors.foregroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 11.5.sp,
              ),
            ),
            UnderlinedTextField(
              fullWidth: true,
              labelText: "Username",
              controller: _userNameController,
            ),
          ],
        ),
      ),
    );
  }
}
