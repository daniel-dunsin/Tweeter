import 'dart:io';

import 'package:client/modules/auth/models/login_model.dart';
import 'package:client/modules/auth/models/reset_password_model.dart';
import 'package:client/modules/auth/models/sign_up_model.dart';
import 'package:client/modules/auth/models/verify_email_model.dart';
import 'package:client/modules/auth/services/auth_service.dart';
import 'package:client/shared/utils/file.dart';

class AuthRepository {
  final AuthService authService;

  const AuthRepository(this.authService);

  signUp(SignUpModel signUpDto) async {
    final response = await this.authService.signUp(signUpDto.toMap());

    return response.data;
  }

  verifyEmail(VerifyEmailModel verifyEmailDto) async {
    final response = await this.authService.verifyEmail(verifyEmailDto.toMap());

    return response.data;
  }

  checkCredential(String credential) async {
    final response = await this.authService.checkCredential(credential);

    return response.data;
  }

  login(LoginModel loginDto) async {
    final response = await this.authService.login(loginDto.toMap());

    return response.data;
  }

  forgotPassword(String credential) async {
    final response = await this.authService.forgotPassword(credential);

    return response.data;
  }

  confirmPasswordResetCode(String code) async {
    final response = await this.authService.confirmPasswordResetCode(code);

    return response.data;
  }

  resetPassword(ResetPasswordModel resetPasswordDto) async {
    final response = await this.authService.resetPassword(resetPasswordDto.toMap());

    return response.data;
  }

  updateUserProfilePicture(File profilePicture) async {
    final response = await this.authService.updateProfilePicture(convertImageToBase64(profilePicture));

    return response.data;
  }

  getUser() async {
    final response = await this.authService.getUser();

    return response.data;
  }

  authWithGoogle(String accessToken) async {
    final response = await this.authService.authWithGoogle(accessToken);

    return response.data;
  }
}
