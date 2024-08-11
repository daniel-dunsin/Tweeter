import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/modules/auth/repository/auth_repository.dart';
import 'package:client/shared/utils/network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitialState()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthSignUpLoading());
      try {
        final response = await this.authRepository.signUp(event.signUpDto);

        emit(AuthSignUpSuccess());
      } on DioException catch (e) {
        handleError(e: e);
        emit(AuthSignUpError());
      }
    });
  }
}
