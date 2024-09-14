import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DrawerNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final bool isSubItem;

  const DrawerNavItem({super.key, 
    required this.icon,
    required this.label,
    required this.route,
    this.isSubItem = false,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final user = context.read<AppCubit>().state.user;

    return ListTile(
      onTap: () {
        GoRouter.of(context).pushNamed(
          route,
          extra: {
            "userId": user?.id
          },
        );
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 3),
      leading: Icon(
        icon,
        color: appColors.foregroundColor,
        size: isSubItem ? 20 : 30,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: appColors.foregroundColor,
          fontWeight: FontWeight.w600,
          fontSize: isSubItem ? 14 : 18,
        ),
      ),
      horizontalTitleGap: 10,
      minTileHeight: isSubItem ? 20 : 50,
      titleAlignment: ListTileTitleAlignment.center,
    );
  }
}
