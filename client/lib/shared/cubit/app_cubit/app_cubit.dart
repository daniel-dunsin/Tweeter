import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/shared/constants/localstorage.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit_state.dart';
import 'package:client/shared/utils/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(AppCubitState());

  setUser(UserModel user) {
    final newState = state.copyWith(user: user);

    emit(newState);
  }

  setFollowers(List<UserModel> followers) {
    emit(state.copyWith(followers: followers));
  }

  setFollowings(List<UserModel> following) {
    emit(state.copyWith(following: following));
  }

  signOut() {
    emit(AppCubitState(isLightMode: state.isLightMode));
  }

  setAppMode(BuildContext context, AppBrightness _brightness) async {
    if (_brightness == AppBrightness.deviceSettings) {
      final deviceBrightness = MediaQuery.of(context).platformBrightness;

      if (deviceBrightness == Brightness.dark) {
        emit(state.copyWith(isLightMode: false));
      } else {
        emit(state.copyWith(isLightMode: true));
      }
    } else {
      emit(state.copyWith(isLightMode: _brightness == AppBrightness.light));
    }

    await LocalStorage.setString(key: localStorageConstants.appBrightness, value: _brightness.name);
  }
}
