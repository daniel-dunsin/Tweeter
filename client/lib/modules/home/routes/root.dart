import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/home/routes/communities/communities.dart';
import 'package:client/modules/home/routes/home/home.dart';
import 'package:client/modules/home/routes/messages/messages.dart';
import 'package:client/modules/home/routes/notifications/notifications.dart';
import 'package:client/modules/home/routes/search/search.dart';
import 'package:client/modules/home/widgets/home_bottom_nav.dart';
import 'package:client/modules/home/widgets/home_drawer.dart';
import 'package:client/shared/cubit/app_cubit.dart';
import 'package:client/shared/widgets/logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class RootHome extends StatefulWidget {
  const RootHome({super.key});

  @override
  State<RootHome> createState() => _RootHomeState();
}

final List<Widget> screens = [
  HomeScreen(),
  SearchScreen(),
  CommunitiesScreen(),
  NotificationsScreen(),
  MessagesScreen(),
];

class _RootHomeState extends State<RootHome> {
  int currentPageIndex = 0;

  void changePage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? user = context.read<AppCubit>().state.user!;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              user?.profilePicture as String,
            ),
          ),
        ),
        centerTitle: true,
        title: Logo(),
      ),
      drawer: HomeDrawer(),
      bottomNavigationBar: HomeBottomNav(
        currentPage: currentPageIndex,
        onChangePage: changePage,
      ),
      body: SafeArea(
        child: IndexedStack(
          children: screens,
          index: currentPageIndex,
        ),
      ),
    );
  }
}
