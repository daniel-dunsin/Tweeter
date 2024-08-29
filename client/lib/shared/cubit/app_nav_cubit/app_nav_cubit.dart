import 'package:client/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final bottomNavIndex = 0;

class AppNavCubit extends Cubit<int> {
  AppNavCubit() : super(bottomNavIndex);

  setBottomNavIndex(int index, BuildContext context) {
    emit(index);

    if (ModalRoute.of(context)?.settings.name != PrivateRoutes.rootHome) {
      Navigator.of(context).pushNamed(PrivateRoutes.rootHome);
    }
  }
}
