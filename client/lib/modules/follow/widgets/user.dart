import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final UserModel user;
  const UserListTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>().state;
    final loggedInUser = appCubit.user!;
    final followers = appCubit.followers;
    final followings = appCubit.following;

    return const Placeholder();
  }
}
