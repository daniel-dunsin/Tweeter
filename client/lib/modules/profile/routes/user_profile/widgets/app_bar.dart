import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/follow/enums/index.dart';
import 'package:client/modules/follow/widgets/follow_button.dart';
import 'package:client/modules/profile/routes/edit_profile/edit_profile.dart';
import 'package:client/modules/profile/routes/user_profile/widgets/tab_bar.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/misc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class UserProfileAppBar extends StatefulWidget {
  final ScrollController scrollController;
  final TabController tabController;
  final UserModel? user;
  final List<UserModel>? followers;
  final List<UserModel>? followings;

  const UserProfileAppBar({
    super.key,
    required this.scrollController,
    required this.tabController,
    this.user,
    this.followers,
    this.followings,
  });

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final loggedInUser = context.watch<AppCubit>().state.user;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return StatefulBuilder(
      builder: (context, setState) {
        return SliverAppBar(
          automaticallyImplyLeading: false,
          expandedHeight: 450,
          collapsedHeight: 120,
          toolbarHeight: 70,
          pinned: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            title: widget.scrollController.hasClients && widget.scrollController.offset > 120
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Expanded(
                          // height: 100,
                          child: Stack(
                            fit: StackFit.loose,
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
                                        "${widget.user?.name}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        "196 posts",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        UserProfileTabBar(tabController: widget.tabController),
                      ],
                    ),
                  )
                : const SizedBox(),
            background: Opacity(
              opacity: widget.scrollController.hasClients && widget.scrollController.offset < 120 ? 1 : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 210,
                    child: Stack(
                      children: [
                        widget.user?.coverPicture != null
                            ? SizedBox(
                                height: 150,
                                child: Stack(
                                  children: [
                                    Image(
                                      image: NetworkImage(widget.user?.coverPicture as String),
                                      height: 150,
                                      width: double.maxFinite,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: appColors.iconColor,
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromRGBO(0, 0, 0, 0.4),
                                            Color.fromRGBO(0, 0, 0, 0.5),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                color: appColors.iconColor,
                                height: 150,
                              ),
                        Positioned(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(widget.user?.profilePicture as String),
                          ),
                          top: 110,
                          left: 10,
                        ),
                        Positioned(
                          child: Visibility(
                            child: TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useRootNavigator: true,
                                  sheetAnimationStyle: AnimationStyle(duration: const Duration(milliseconds: 500)),
                                  builder: (context) {
                                    return EditProfileScreen(
                                      initialUser: widget.user!,
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  side: const BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                ),
                                foregroundColor: appColors.foregroundColor,
                              ),
                            ),
                            replacement: FollowButton(user: widget.user!),
                            visible: widget.user?.id == loggedInUser?.id,
                          ),
                          top: 155,
                          right: 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.user?.name}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: appColors.foregroundColor,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "@${widget.user?.userName}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 20),
                        widget.user?.bio != null
                            ? Text(
                                "${widget.user?.bio}",
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
                                const WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    Icons.link,
                                    color: Colors.grey,
                                  ),
                                ),
                                const WidgetSpan(child: SizedBox(width: 6)),
                                WidgetSpan(
                                  child: widget.user?.website != null
                                      ? GestureDetector(
                                          onTap: () {
                                            openUrl(widget.user?.website as String);
                                          },
                                          child: Text(
                                            "${widget.user?.website}",
                                            style: TextStyle(
                                              color: appColors.iconColor,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                            style: const TextStyle(color: Colors.grey),
                            softWrap: true,
                          ),
                          visible: widget.user?.website != null && widget.user!.website?.trim() != "",
                        ),
                        const SizedBox(height: 3),
                        Text.rich(
                          TextSpan(
                            children: [
                              const WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                              const WidgetSpan(child: SizedBox(width: 6)),
                              WidgetSpan(
                                child: Text(
                                  "Joined ${DateFormat.yMMMM().format(widget.user?.createdAt as DateTime)}",
                                ),
                              ),
                            ],
                          ),
                          style: const TextStyle(color: Colors.grey),
                          softWrap: true,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                GoRouter.of(context).pushNamed(
                                  PrivateRoutes.follows,
                                  extra: {
                                    "user": widget.user,
                                    "tab": FollowsTabs.followers,
                                  },
                                );
                              },
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Text(
                                        " ${widget.followings?.length}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: appColors.foregroundColor,
                                        ),
                                      ),
                                    ),
                                    const WidgetSpan(
                                      child: Text(
                                        " Following",
                                      ),
                                    ),
                                  ],
                                ),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {
                                GoRouter.of(context).pushNamed(
                                  PrivateRoutes.follows,
                                  extra: {
                                    "user": widget.user,
                                    "tab": FollowsTabs.followings,
                                  },
                                );
                              },
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Text(
                                        "${widget.followers?.length}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: appColors.foregroundColor,
                                        ),
                                      ),
                                    ),
                                    const WidgetSpan(
                                      child: Text(
                                        " Followers",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        UserProfileTabBar(tabController: widget.tabController),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
