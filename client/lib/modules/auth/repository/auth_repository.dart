import 'package:client/modules/auth/models/sign_up_model.dart';
import 'package:client/modules/auth/models/verify_email_model.dart';
import 'package:client/modules/auth/services/auth_service.dart';

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
}
