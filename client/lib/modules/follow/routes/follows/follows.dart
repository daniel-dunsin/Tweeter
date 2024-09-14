import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/follow/bloc/follows_bloc.dart';
import 'package:client/modules/follow/enums/index.dart';
import 'package:client/modules/follow/widgets/no_follower.dart';
import 'package:client/modules/follow/widgets/no_following.dart';
import 'package:client/modules/follow/widgets/users_list.dart';
import 'package:client/modules/home/widgets/home_bottom_nav.dart';
import 'package:client/shared/theme/colors.dart';
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
    final screenArgs = ModalRoute.settingsOf(context)?.arguments as Map<String, dynamic>?;

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
    final screenArgs = ModalRoute.settingsOf(context)?.arguments as Map<String, dynamic>?;
    final user = screenArgs?["user"] as UserModel;

    return Scaffold(
      bottomNavigationBar: const HomeBottomNav(),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            GoRouter.of(context).pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(user.name),
        titleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: appColors.foregroundColor),
        shape: const Border(bottom: BorderSide(width: .6, color: Colors.grey)),
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
                        users: followings,
                        replacement: const NoFollowing(message: "You're not following anyone yet."),
                      ),
                    ],
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
