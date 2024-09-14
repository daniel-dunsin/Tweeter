import 'package:client/shared/cubit/app_nav_cubit/app_nav_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<IconData> bottomNavTabsIcons = [
  Icons.home_outlined,
  Icons.search_outlined,
  Icons.people_alt_outlined,
  Icons.notifications_outlined,
  Icons.mail_outlined,
];

final List<IconData> bottomNavTabsSelectedIcons = [
  Icons.home_filled,
  Icons.search_outlined,
  Icons.people,
  Icons.notifications,
  Icons.mail,
];

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final appNavCubit = context.watch<AppNavCubit>();

    return Theme(
      data: Theme.of(context).copyWith(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: appColors.secondaryForegroundColor,
            ),
          ),
        ),
        child: NavigationBar(
          destinations: [
            for (int i = 0; i < bottomNavTabsIcons.length; i++)
              NavigationDestination(
                icon: Icon(
                  bottomNavTabsIcons[i],
                  color: appColors.foregroundColor,
                  size: 27,
                ),
                label: "",
                selectedIcon: Icon(
                  bottomNavTabsSelectedIcons[i],
                  color: appColors.foregroundColor,
                  size: 27,
                ),
              ),
          ],
          indicatorColor: Colors.transparent,
          backgroundColor: appColors.backgroundColor,
          animationDuration: const Duration(milliseconds: 300),
          selectedIndex: appNavCubit.state,
          onDestinationSelected: (int screen) {
            appNavCubit.setBottomNavIndex(screen, context);
          },
        ),
      ),
    );
  }
}
