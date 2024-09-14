import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/follow/widgets/follow_button.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/button.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter/material.dart';

class UserListTile extends StatefulWidget {
  final UserModel user;
  const UserListTile({super.key, required this.user});

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.user.profilePicture),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.name,
                        style: TextStyle(
                          color: appColors.foregroundColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        widget.user.bio ?? "",
                        style: TextStyle(
                          color: appColors.secondaryForegroundColor,
                          fontSize: 12,
                        ),
                      ),
                      FollowButton(user: widget.user)
                    ],
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
