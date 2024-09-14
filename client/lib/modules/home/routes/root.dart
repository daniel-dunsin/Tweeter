import 'package:client/modules/home/widgets/home_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootHome extends StatelessWidget {
  final StatefulNavigationShell shell;
  const RootHome({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: HomeBottomNav(shell: shell),
      body: shell,
    );
  }
}
