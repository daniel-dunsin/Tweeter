import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

final List<String> bottomNavRoutes = [
  PrivateRoutes.home,
  PrivateRoutes.search,
  PrivateRoutes.communities,
  PrivateRoutes.notifications,
  PrivateRoutes.chat,
];

class HomeBottomNav extends StatelessWidget {
  final StatefulNavigationShell shell;
  const HomeBottomNav({
    super.key,
    required this.shell,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Theme(
      data: Theme.of(context).copyWith(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        canvasColor: appColors.backgroundColor,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: appColors.secondaryForegroundColor,
            ),
          ),
        ),
        child: BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          currentIndex: shell.currentIndex,
          onTap: (i) {
            if (i == shell.currentIndex) {
              GoRouter.of(context).push(bottomNavRoutes[i]);
            } else {
              shell.goBranch(i);
            }
          },
          items: [
            for (int i = 0; i < bottomNavTabsIcons.length; i++)
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(
                  bottomNavTabsIcons[i],
                  color: appColors.foregroundColor,
                  size: 27,
                ),
                label: "",
                activeIcon: Icon(
                  bottomNavTabsSelectedIcons[i],
                  color: appColors.foregroundColor,
                  size: 27,
                ),
              ),
          ],
          backgroundColor: appColors.backgroundColor,
          selectedItemColor: appColors.iconColor,
          unselectedItemColor: appColors.iconColor,
        ),
      ),
    );
  }
}
