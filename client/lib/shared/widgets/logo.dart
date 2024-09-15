import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightMode = context.read<AppCubit>().state.isLightMode;

    return Image.asset(
      isLightMode ? "assets/images/logo-light.jpg" : "assets/images/logo.jpg",
      width: 70,
      height: 70,
    );
  }
}
