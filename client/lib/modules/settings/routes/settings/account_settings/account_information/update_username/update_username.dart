import 'package:client/modules/settings/bloc/settings_bloc.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/validators.dart';
import 'package:client/shared/widgets/custom_app_bar.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UpdateUsernameScreen extends StatefulWidget {
  const UpdateUsernameScreen({super.key});

  @override
  State<UpdateUsernameScreen> createState() => _UpdateUsernameScreenState();
}

class _UpdateUsernameScreenState extends State<UpdateUsernameScreen> {
  final _userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(() {
      setState(() {});
    });
  }

  void submit() {
    context.read<SettingsBloc>().add(UpdateUserNameRequested(_userNameController.text));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppCubit>().state.user!;
    final appColors = Theme.of(context).appColors;

    return BlocConsumer<SettingsBloc, SettingsState>(listener: (context, state) {
      if (state is UpdateUsernameSuccessful) {
        GoRouter.of(context).pop();
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: getMiscScreensAppBar(
          context,
          toolbarHeight: 60,
          title: Text(
            "Update username",
            style: TextStyle(
              fontSize: 14.h,
              fontWeight: FontWeight.bold,
              color: appColors.foregroundColor,
            ),
          ),
          actions: [
            Visibility(
              child: GestureDetector(
                onTap: state is UpdateUsernameLoading ? null : submit,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                  ),
                  child: Text(
                    state is UpdateUsernameLoading ? "Saving..." : "Done",
                    style: TextStyle(
                      color: appColors.foregroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.h,
                    ),
                  ),
                ),
              ),
              visible: _userNameController.text.isNotEmpty,
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current",
                  style: TextStyle(
                    color: appColors.foregroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5.h,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${user.userName}",
                  style: TextStyle(
                    color: appColors.foregroundColor,
                    fontSize: 11.h,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "New",
                  style: TextStyle(
                    color: appColors.foregroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5.h,
                  ),
                ),
                UnderlinedTextField(
                  fullWidth: true,
                  labelText: "Username",
                  controller: _userNameController,
                  validator: requiredFieldValidator,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
