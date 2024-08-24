import 'package:client/shared/cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:intl/intl.dart';

class UserProfileAppBar extends StatelessWidget {
  final ScrollController scrollController;

  const UserProfileAppBar({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final user = context.read<AppCubit>().state.user;
    final followers = context.read<AppCubit>().state.followers;
    final followings = context.read<AppCubit>().state.following;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 400,
      collapsedHeight: 70,
      toolbarHeight: 70,
      pinned: true,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        title: scrollController.hasClients && scrollController.offset > 60
            ? Stack(
                children: [
                  Container(color: appColors.iconColor),
                  Positioned(
                    left: 70,
                    top: 5,
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${user?.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "196 posts",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : SizedBox(),
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 210,
              child: Stack(
                children: [
                  user?.coverPicture != null
                      ? Image(
                          image: NetworkImage(user?.coverPicture as String),
                          height: 150,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: appColors.iconColor,
                          height: 150,
                        ),
                  Positioned(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user?.profilePicture as String),
                    ),
                    top: 110,
                    left: 10,
                  ),
                  Positioned(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          side: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        foregroundColor: appColors.foregroundColor,
                      ),
                    ),
                    top: 155,
                    right: 20,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user?.name}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: appColors.foregroundColor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "@${user?.userName}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  user?.bio != null
                      ? Text(
                          "${user?.bio}",
                          style: TextStyle(
                            color: appColors.foregroundColor,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 5),
                  Visibility(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.link,
                              color: Colors.grey,
                            ),
                          ),
                          WidgetSpan(child: const SizedBox(width: 6)),
                          WidgetSpan(
                            child: Text(
                              "${user?.website}",
                              style: TextStyle(
                                color: appColors.iconColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      style: TextStyle(color: Colors.grey),
                      softWrap: true,
                    ),
                    visible: user?.website != null,
                  ),
                  const SizedBox(height: 3),
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        WidgetSpan(child: const SizedBox(width: 6)),
                        WidgetSpan(
                          child: Text(
                            "Joined ${DateFormat.yMMMM().format(user?.createdAt as DateTime)}",
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(color: Colors.grey),
                    softWrap: true,
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: Text(
                            " ${followings?.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appColors.foregroundColor,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Text(
                            " Following",
                          ),
                        ),
                        WidgetSpan(child: const SizedBox(width: 15)),
                        WidgetSpan(
                          child: Text(
                            "${followers?.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appColors.foregroundColor,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Text(
                            " Followers",
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
