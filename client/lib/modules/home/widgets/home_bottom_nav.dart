import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

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
  final int currentPage;
  final Function(int index) onChangePage;

  const HomeBottomNav({
    super.key,
    required this.currentPage,
    required this.onChangePage,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

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
        child: StatefulBuilder(builder: (context, setState) {
          return NavigationBar(
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
            animationDuration: Duration(milliseconds: 300),
            selectedIndex: currentPage,
            onDestinationSelected: (int screen) {
              onChangePage(screen);
              setState(() {});
            },
          );
        }),
      ),
    );
  }
}
