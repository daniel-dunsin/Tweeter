import 'package:client/shared/utils/network.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  void get() async {
    await httpWrapper(request: () async {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
