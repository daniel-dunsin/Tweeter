import 'package:client/modules/home/routes/home/widgets/following.dart';
import 'package:client/modules/home/routes/home/widgets/for_you.dart';
import 'package:client/modules/home/widgets/app_bar.dart';
import 'package:client/modules/home/widgets/home_drawer.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/logo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      drawer: const HomeDrawer(),
      appBar: getHomeRoutesAppBar(context: context, title: const Logo()),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            unselectedLabelColor: Colors.grey,
            labelColor: appColors.foregroundColor,
            indicatorColor: appColors.iconColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 4,
            labelStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: "For you"),
              Tab(text: "Following")
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                ForYou(),
                Following(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
