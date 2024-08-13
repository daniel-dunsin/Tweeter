import 'package:client/shared/constants/secrets.dart';
import 'package:dio/dio.dart';

class AuthService {
  final httpInstance = Dio();

  Future<Response> signUp(Map<String, dynamic> signUpDto) async {
    return await httpInstance.post(
      "${AppSecrets.serverUrl}/auth/sign-up",
      data: signUpDto,
    );
  }

  Future<Response> verifyEmail(Map<String, dynamic> verifyEmailDto) async {
    return await httpInstance.post(
      "${AppSecrets.serverUrl}/auth/verify-email",
      data: verifyEmailDto,
    );
  }

  Future<Response> checkCredential(String credential) async {
    return await httpInstance.post("${AppSecrets.serverUrl}/auth/check-credential", data: {
      "credential": credential
    });
  }

  Future<Response> login(Map<String, String> loginDto) async {
    return await httpInstance.post("${AppSecrets.serverUrl}/auth/login", data: loginDto);
  }
}
