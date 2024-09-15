import 'package:client/modules/settings/models/change_password_model.dart';
import 'package:client/modules/settings/repository/settings_repository.dart';
import 'package:client/shared/constants/localstorage.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/utils/localstorage.dart';
import 'package:client/shared/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;
  final AppCubit appCubit;

  SettingsBloc({required this.settingsRepository, required this.appCubit}) : super(SettingsInitialState()) {
    on<DeactivateAccountRequested>(
      (event, emit) async {
        emit(DeactivateAccountLoading());

        try {
          await settingsRepository.deactivateAccount();
          appCubit.signOut();
          await LocalStorage.removeEntry(key: localStorageConstants.accessToken);
          await LocalStorage.removeEntry(key: localStorageConstants.user);
          emit(DeactivateAccountSuccessful());
        } catch (e) {
          emit(DeactivateAccountError());
          handleError(e: e);
        }
      },
    );

    on<ChangePasswordRequested>(
      (event, emit) async {
        emit(ChangePasswordLoading());
        try {
          final response = await settingsRepository.changePassword(event.changePasswordModel);

          final accessToken = await response["meta"]["accessToken"];

          await LocalStorage.setString(
            key: localStorageConstants.accessToken,
            value: accessToken,
          );

          emit(ChangePasswordSuccessful());
        } catch (e) {
          handleError(e: e);
          emit(ChangePasswordError());
        }
      },
    );

    on<SignOutRequested>(
      (event, emit) async {
        emit(SignOutLoading());

        try {
          await this.settingsRepository.signOut();

          await LocalStorage.removeEntry(key: localStorageConstants.accessToken);
          await LocalStorage.removeEntry(key: localStorageConstants.user);
          appCubit.signOut();

          emit(SignOutSuccessful());
        } catch (e) {
          handleError(e: e);
          emit(SignOutError());
        }
      },
    );
  }
}
