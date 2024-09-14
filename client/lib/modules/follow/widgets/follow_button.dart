import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowButton extends StatefulWidget {
  final UserModel user;
  const FollowButton({
    super.key,
    required this.user,
  });

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>().state;
    final appColors = Theme.of(context).appColors;
    final loggedInUser = appCubit.user!;
    final followers = appCubit.followers ?? [];
    final followings = appCubit.following ?? [];

    final bool youFollow = followings.where((following) => following.id == widget.user.id).toList().isNotEmpty;
    final bool followsYou = followers.where((follower) => follower.id == widget.user.id).toList().isNotEmpty;
    return ContainedButton(
      onPressed: () {
        if (!youFollow) {
          showMenu(
            color: appColors.backgroundColor,
            shadowColor: appColors.secondaryForegroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            context: context,
            position: const RelativeRect.fromLTRB(100, 300, 0, 0), // Position the menu
            items: [
              PopupMenuItem(
                child: Center(
                  child: Text(
                    'Unfollow @${widget.user.userName}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                height: 2,
                onTap: () {
                  // Handle unfollow action
                },
              ),
            ],
          );
        }
      },
      child: Text(
        youFollow
            ? "Unfollow"
            : followsYou
                ? "Follow Back"
                : "Follow",
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      height: 30,
      width: double.minPositive,
      backgroundColor: youFollow ? Colors.transparent : null,
      foregroundColor: youFollow ? appColors.foregroundColor : null,
      borderSide: youFollow ? const BorderSide(width: 1, color: Colors.grey) : null,
    );
  }
}
