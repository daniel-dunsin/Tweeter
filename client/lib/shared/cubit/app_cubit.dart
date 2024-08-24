import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/shared/cubit/app_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(AppCubitState());

  setUser(UserModel user) {
    final newState = state.copyWith(user: user);

    emit(newState);
  }
}
