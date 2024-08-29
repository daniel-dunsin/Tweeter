import 'package:client/config/routes.dart';
import 'package:client/modules/home/widgets/drawer_nav_item.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

final navs = <DrawerNavItem>[
  DrawerNavItem(
    icon: Icons.person_outline_rounded,
    label: "Profile",
    route: PrivateRoutes.profile,
  ),
  DrawerNavItem(
    icon: Icons.workspace_premium_outlined,
    label: "Premium",
    route: "/private/premium",
  ),
  DrawerNavItem(
    icon: Icons.bookmark_outline_outlined,
    label: "Bookmarks",
    route: "/private/profile",
  ),
  DrawerNavItem(
    icon: Icons.list_alt_outlined,
    label: "Lists",
    route: "/private/lists",
  ),
];

final settingsNav = <DrawerNavItem>[
  DrawerNavItem(
    icon: Icons.settings_outlined,
    label: "Settings",
    route: "/private/profile",
    isSubItem: true,
  ),
  DrawerNavItem(
    icon: Icons.help_outlined,
    label: "Help Center",
    route: "/private/premium",
    isSubItem: true,
  ),
];

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool settingsOpen = false;

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    final appColors = Theme.of(context).appColors;
    final user = appCubit.state.user!;
    final followers = appCubit.state.followers;
    final followings = appCubit.state.following;

    return Drawer(
      width: MediaQuery.of(context).size.width * .8,
      backgroundColor: appColors.secondaryBackgroundColor,
      shape: RoundedRectangleBorder(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(PrivateRoutes.profile, arguments: {
                          "userId": user.id
                        });
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(user.profilePicture),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.name,
                      style: TextStyle(
                        color: appColors.foregroundColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "@${user.userName}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "${followers?.length ?? 0} ",
                      style: TextStyle(
                        color: appColors.foregroundColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Following    ",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "${followings?.length ?? 0} ",
                      style: TextStyle(
                        color: appColors.foregroundColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Followers",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                for (int i = 0; i < navs.length; i++) navs[i],
                const SizedBox(height: 30),
                Divider(),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Settings and Support",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: appColors.foregroundColor,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(600),
                      onTap: () {
                        setState(() {
                          settingsOpen = !settingsOpen;
                        });
                      },
                      child: AnimatedRotation(
                        turns: settingsOpen ? .5 : 0,
                        duration: Duration(milliseconds: 400),
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: settingsOpen ? appColors.iconColor : appColors.foregroundColor,
                          size: 27,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                AnimatedOpacity(
                  opacity: settingsOpen ? 1 : 0,
                  duration: Duration(milliseconds: 400),
                  child: Column(
                    children: [
                      for (int i = 0; i < settingsNav.length; i++) settingsNav[i],
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
