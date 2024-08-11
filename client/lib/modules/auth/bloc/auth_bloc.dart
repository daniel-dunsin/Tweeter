import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/auth/repository/auth_repository.dart';
import 'package:client/shared/constants/localstorage.dart';
import 'package:client/shared/utils/localstorage.dart';
import 'package:client/shared/utils/network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitialState()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthSignUpLoading());
      try {
        await this.authRepository.signUp(event.signUpDto);

        emit(AuthSignUpSuccess());
      } on DioException catch (e) {
        handleError(e: e);
        emit(AuthSignUpError());
      }
    });

    on<VerifyEmailRequested>((event, emit) async {
      emit(AuthVerifyEmailLoading());
      try {
        final response = await this.authRepository.verifyEmail(event.verifyEmailDto);

        final Map<String, dynamic> userMap = response["data"];
        final user = UserModel.fromMap(userMap);
        final String accessToken = response["meta"]["accessToken"];

        await LocalStorage.setString(key: localStorageConstants.user, value: user.toJson());
        await LocalStorage.setString(key: localStorageConstants.accessToken, value: accessToken);

        emit(AuthVerifyEmailSuccess(user: user));
      } catch (e) {
        handleError(e: e);
        emit(AuthVerifyEmailError());
      }
    });
  }
}
