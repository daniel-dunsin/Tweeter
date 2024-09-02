import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/button.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final UserModel user;
  const UserListTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final appCubit = context.watch<AppCubit>().state;
    final loggedInUser = appCubit.user!;
    final followers = appCubit.followers;
    final followings = appCubit.following;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.profilePicture),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.name}",
                    style: TextStyle(
                      color: appColors.foregroundColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    user.bio ?? "",
                    style: TextStyle(
                      color: appColors.secondaryForegroundColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            ContainedButton(
              child: Text(
                "Follow",
                style: TextStyle(fontSize: 12),
              ),
              height: 30,
              width: double.minPositive,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
