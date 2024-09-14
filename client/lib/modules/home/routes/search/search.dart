import 'package:client/modules/home/widgets/app_bar.dart';
import 'package:client/modules/home/widgets/home_drawer.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: getHomeRoutesAppBar(context: context),
    );
  }
}
