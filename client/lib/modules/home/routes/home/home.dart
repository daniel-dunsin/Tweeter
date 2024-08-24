import 'package:client/modules/home/routes/home/widgets/following.dart';
import 'package:client/modules/home/routes/home/widgets/for_you.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: appColors.secondaryForegroundColor,
              ),
            ),
          ),
          child: AppBar(
            bottom: TabBar(
              controller: tabController,
              unselectedLabelColor: Colors.grey,
              labelColor: appColors.foregroundColor,
              indicatorColor: appColors.iconColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
              labelStyle: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              tabs: [
                Tab(text: "For you"),
                Tab(text: "Following")
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ForYou(),
          Following(),
        ],
      ),
    );
  }
}
