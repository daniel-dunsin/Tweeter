import 'package:client/modules/auth/models/sign_up_model.dart';
import 'package:client/modules/auth/services/auth_service.dart';
import 'package:client/shared/utils/network.dart';

class AuthRepository {
  final AuthService authService;

  const AuthRepository(this.authService);

  signUp(SignUpModel signUpDto) async {
    try {
      final response = await this.authService.signUp(signUpDto.toMap());

      return response.data;
    } catch (e) {
      throw e;
    }
  }
}
