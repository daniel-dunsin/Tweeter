import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/follow/models/user_follows_model.dart';
import 'package:client/modules/follow/service/follow_service.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/network.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final _followService = FollowService();
  bool _isLoading = false;

  void followUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _followService.followUser(widget.user.id);
      await getFollows();
    } catch (e) {
      handleError(e: e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void unfollowUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _followService.unFollowUser(widget.user.id);
      await getFollows();
    } catch (e) {
      handleError(e: e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> getFollows() async {
    final appCubit = context.read<AppCubit>();
    final response = await _followService.getUserFollows(appCubit.state.user!.id);

    final data = response.data["data"];

    final followers = data["followers"];
    final followings = data["followings"];
    final verifiedFollowers = data["verifiedFollowers"];

    final follows = UserFollowsModel.fromMap(
      {
        "followers": followers,
        "followings": followings,
        "verifiedFollowers": verifiedFollowers,
      },
    );

    appCubit.setFollowers(follows.followers);
    appCubit.setFollowings(follows.followings);
  }

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>().state;
    final appColors = Theme.of(context).appColors;
    final followers = appCubit.followers ?? [];
    final followings = appCubit.following ?? [];

    final bool youFollow = followings.where((following) => following.id == widget.user.id).toList().isNotEmpty;
    final bool followsYou = followers.where((follower) => follower.id == widget.user.id).toList().isNotEmpty;

    return GestureDetector(
      onTapDown: (details) {
        final offset = details.globalPosition;

        if (!_isLoading) {
          if (youFollow) {
            showMenu(
              color: appColors.secondaryBackgroundColor,
              // shadowColor: appColors.secondaryForegroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              context: context,
              position: RelativeRect.fromLTRB(offset.dx, offset.dy + 20, 0, 0), // Position the menu
              items: [
                PopupMenuItem(
                  child: Center(
                    child: Text(
                      'Unfollow @${widget.user.userName}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 9.h,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                  height: 2,
                  onTap: () {
                    unfollowUser();
                  },
                ),
              ],
            );
          } else {
            followUser();
          }
        }
      },
      child: ContainedButton(
        child: Text(
          youFollow
              ? "Unfollow"
              : followsYou
                  ? "Follow Back"
                  : "Follow",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        onPressed: null,
        height: 30,
        width: double.minPositive,
        disabledBackgroundColor: youFollow ? Colors.transparent : appColors.foregroundColor,
        disabledForegroundColor: youFollow ? appColors.foregroundColor : appColors.backgroundColor,
        borderSide: youFollow ? const BorderSide(width: 1, color: Colors.grey) : null,
        loading: _isLoading,
      ),
    );
  }
}
