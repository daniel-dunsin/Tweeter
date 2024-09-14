import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar getHomeRoutesAppBar({required BuildContext context, Widget? title}) {
  final UserModel? user = context.watch<AppCubit>().state.user;

  return AppBar(
    leading: Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            if (Scaffold.of(context).hasDrawer) {
              Scaffold.of(context).openDrawer();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                user?.profilePicture as String,
              ),
            ),
          ),
        );
      },
    ),
    centerTitle: true,
    title: title,
  );
}
