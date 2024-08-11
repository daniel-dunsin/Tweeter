import 'package:client/modules/auth/models/sign_up_model.dart';
import 'package:client/shared/constants/secrets.dart';
import 'package:client/shared/utils/network.dart';
import 'package:dio/dio.dart';

class AuthService {
  final httpInstance = Dio();

  Future<Response> signUp(Map<String, dynamic> signUpDto) async {
    return await httpInstance.post(
      "${AppSecrets.serverUrl}/auth/sign-up",
      data: signUpDto,
    );
  }
}
