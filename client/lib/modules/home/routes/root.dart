import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/home/routes/communities/communities.dart';
import 'package:client/modules/home/routes/home/home.dart';
import 'package:client/modules/home/routes/messages/messages.dart';
import 'package:client/modules/home/routes/notifications/notifications.dart';
import 'package:client/modules/home/routes/search/search.dart';
import 'package:client/modules/home/widgets/home_bottom_nav.dart';
import 'package:client/modules/home/widgets/home_drawer.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/cubit/app_nav_cubit/app_nav_cubit.dart';
import 'package:client/shared/widgets/logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class RootHome extends StatelessWidget {
  const RootHome({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? user = context.watch<AppCubit>().state.user;
    final appBottomNavIndex = context.watch<AppNavCubit>().state;

    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                if (Scaffold.of(context).hasDrawer) {
                  Scaffold.of(context).openDrawer();
                }
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    user?.profilePicture as String,
                  ),
                ),
              ),
            );
          },
        ),
        centerTitle: true,
        title: Logo(),
      ),
      bottomNavigationBar: HomeBottomNav(),
      body: SafeArea(
        child: IndexedStack(
          children: screens,
          index: appBottomNavIndex,
        ),
      ),
    );
  }
}

final List<Widget> screens = [
  HomeScreen(),
  SearchScreen(),
  CommunitiesScreen(),
  NotificationsScreen(),
  MessagesScreen(),
];
