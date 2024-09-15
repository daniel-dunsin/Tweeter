import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/follow/bloc/follows_bloc.dart';
import 'package:client/modules/follow/enums/index.dart';
import 'package:client/modules/follow/widgets/no_follower.dart';
import 'package:client/modules/follow/widgets/no_following.dart';
import 'package:client/modules/follow/widgets/suggested_followings.dart';
import 'package:client/modules/follow/widgets/users_list.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FollowsScreen extends StatefulWidget {
  final FollowsTabs? tab;
  final UserModel user;

  const FollowsScreen({
    super.key,
    required this.tab,
    required this.user,
  });

  @override
  State<FollowsScreen> createState() => _FollowsScreenState();
}

class _FollowsScreenState extends State<FollowsScreen> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);
  final List<FollowsTabs> tabs = FollowsTabs.values;
  FollowsTabs? currentTab;
  List<UserModel> verifiedFollowers = [];
  List<UserModel> followers = [];
  List<UserModel> followings = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.tab != null && currentTab == null) {
      setState(() {
        currentTab = widget.tab;
        _tabController.index = tabs.indexOf(widget.tab!);
      });
    }

    context.read<FollowsBloc>().add(GetUserFollowsRequested(userId: widget.user.id));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final appCubit = context.watch<AppCubit>().state;
    final loggedInUserFollowings = appCubit.following;
    final loggedInUser = appCubit.user;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            GoRouter.of(context).pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(widget.user.name),
        titleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: appColors.foregroundColor),
        shape: const Border(bottom: BorderSide(width: .6, color: Colors.grey)),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                barrierColor: const Color.fromRGBO(43, 43, 43, 0.6),
                context: context,
                isScrollControlled: true,
                enableDrag: true,
                builder: (context) {
                  return const SuggestedFollowings();
                },
              );
            },
            icon: const Icon(Icons.person_add_alt_1_outlined),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: "Verified Followers",
                ),
                Tab(
                  text: "Followers",
                ),
                Tab(
                  text: "Following",
                )
              ],
              indicatorColor: appColors.iconColor,
              labelColor: appColors.foregroundColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: false,
            ),
          ),
          BlocConsumer<FollowsBloc, FollowsState>(
            listener: (context, state) {
              if (state is GetUserFollowsSuccess) {
                setState(() {
                  followers = state.userFollows.followers;
                  followings = state.userFollows.followings;
                  verifiedFollowers = state.userFollows.verifiedFollowers;
                });
              }
            },
            builder: (context, state) {
              return Visibility(
                child: Expanded(
                  child: Padding(
                    padding: CustomTheme.majorScreenPadding,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        UsersList(
                          users: verifiedFollowers,
                          replacement: const NoFollower(),
                        ),
                        UsersList(
                          users: followers,
                          replacement: const NoFollower(),
                        ),
                        UsersList(
                          users: loggedInUser!.id == widget.user.id ? loggedInUserFollowings! : followings,
                          replacement: loggedInUser.id == widget.user.id
                              ? const NoFollowing(
                                  message: "You're not following anyone yet.",
                                  showSuggestion: true,
                                )
                              : NoFollowing(
                                  message: "${widget.user.name} is not following anyone yet",
                                  showSuggestion: false,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                replacement: Container(
                  padding: const EdgeInsets.all(20),
                  child: LoadingAnimationWidget.discreteCircle(
                    color: appColors.iconColor,
                    secondRingColor: appColors.iconColor,
                    thirdRingColor: appColors.iconColor,
                    size: 20,
                  ),
                ),
                visible: state is! GetUserFollowsLoading,
              );
            },
          ),
        ],
      ),
    );
  }
}
