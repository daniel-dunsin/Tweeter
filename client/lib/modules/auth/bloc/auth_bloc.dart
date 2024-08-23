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

    on<CheckCredentialRequested>((event, emit) async {
      emit(AuthCheckCredentialLoading());

      try {
        final response = await this.authRepository.checkCredential(event.credential);

        final bool accountExists = response["data"]["exists"];

        emit(AuthCheckCredentialSuccess(accountExists: accountExists));
        await Future.delayed(Duration(seconds: 2), () {
          if (!accountExists) {
            emit(AuthInitialState());
          }
        });
      } catch (e) {
        handleError(e: e);
        emit(AuthCheckCredentialError());
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());

      try {
        final response = await this.authRepository.login(event.loginDto);

        final Map<String, dynamic> userMap = response["data"];
        final user = UserModel.fromMap(userMap);
        final String accessToken = response["meta"]["accessToken"];

        await LocalStorage.setString(key: localStorageConstants.user, value: user.toJson());
        await LocalStorage.setString(key: localStorageConstants.accessToken, value: accessToken);

        emit(LoginSuccess(user: user));
      } catch (e) {
        handleError(e: e);
        emit(LoginError());
      }
    });

    on<ForgotPasswordRequested>((event, emit) async {
      emit(ForgotPasswordLoading());

      try {
        await this.authRepository.forgotPassword(event.credential);

        emit(ForgotPasswordSuccess());
      } catch (e) {
        handleError(e: e);
        emit(ForgotPasswordError());
      }
    });

    on<ConfirmPasswordResetCodeRequested>((event, emit) async {
      emit(ConfirmPasswordResetCodeLoading());

      try {
        await this.authRepository.confirmPasswordResetCode(event.code);

        emit(ConfirmPasswordResetCodeSuccess());
      } catch (e) {
        handleError(e: e);
        emit(ConfirmPasswordResetCodeError());
      }
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(ResetPasswordLoading());

      try {
        await this.authRepository.resetPassword(event.resetPasswordDto);

        emit(ResetPasswordSuccess());
      } catch (e) {
        handleError(e: e);
        emit(ResetPasswordError());
      }
    });

    on<UpdateProfilePictureRequested>((event, emit) async {
      emit(UpdateProfilePictureLoading());

      try {
        await this.authRepository.updateUserProfilePicture(event.profilePicture);

        emit(UpdateProfilePictureSuccess());
      } catch (e) {
        handleError(e: e);
        emit(UpdateProfilePictureError());
      }
    });
  }
}
