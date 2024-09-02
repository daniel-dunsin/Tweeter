import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/follow/bloc/follows_bloc.dart';
import 'package:client/modules/follow/enums/index.dart';
import 'package:client/modules/follow/widgets/users_list.dart';
import 'package:client/modules/home/widgets/home_bottom_nav.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FollowsScreen extends StatefulWidget {
  const FollowsScreen({super.key});

  @override
  State<FollowsScreen> createState() => _FollowsScreenState();
}

class _FollowsScreenState extends State<FollowsScreen> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);
  final List<FollowsTabs> tabs = FollowsTabs.values;
  FollowsTabs? currentTab;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final screenArgs = ModalRoute.settingsOf(context)?.arguments as Map<String, dynamic>?;
    final FollowsTabs? tab = screenArgs?["tab"];
    final user = screenArgs?["user"] as UserModel;

    if (tab != null && currentTab == null) {
      setState(() {
        currentTab = tab;
        _tabController.index = tabs.indexOf(tab);
      });
    }

    context.read<FollowsBloc>().add(GetUserFollowsRequested(userId: user.id));

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
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("${user.name}"),
        titleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: appColors.foregroundColor),
        shape: Border(bottom: BorderSide(width: .6, color: Colors.grey)),
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
              tabs: [
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
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: false,
            ),
          ),
          BlocBuilder<FollowsBloc, FollowsState>(
            builder: (context, state) {
              return Visibility(
                child: Expanded(
                  child: state is GetUserFollowsSuccess
                      ? (TabBarView(
                          controller: _tabController,
                          children: [
                            UsersList(users: state.userFollows.verifiedFollowers),
                            UsersList(users: state.userFollows.followers),
                            UsersList(users: state.userFollows.followings),
                          ],
                        ))
                      : SizedBox(),
                ),
                replacement: Container(
                  padding: EdgeInsets.all(20),
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
