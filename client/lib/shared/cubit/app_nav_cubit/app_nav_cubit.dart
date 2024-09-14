import 'package:client/config/navigation/routes_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

const bottomNavIndex = 0;

class AppNavCubit extends Cubit<int> {
  AppNavCubit() : super(bottomNavIndex);

  setBottomNavIndex(int index, BuildContext context) {
    emit(index);

    if (ModalRoute.of(context)?.settings.name != PrivateRoutes.rootHome) {
      GoRouter.of(context).pushNamed(PrivateRoutes.rootHome);
    }
  }
}
