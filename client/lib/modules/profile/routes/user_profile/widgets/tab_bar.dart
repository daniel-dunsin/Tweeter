import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class UserProfileTabBar extends StatelessWidget {
  final TabController tabController;

  const UserProfileTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TabBar(
        controller: tabController,
        indicatorWeight: 3,
        indicatorColor: appColors.iconColor,
        unselectedLabelColor: Colors.grey,
        labelColor: appColors.foregroundColor,
        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(text: "Posts"),
          Tab(text: "Replies"),
          Tab(text: "Media"),
          Tab(text: "Likes"),
        ],
      ),
    );
  }
}
