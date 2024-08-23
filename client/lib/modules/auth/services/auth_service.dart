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

  Future<Response> verifyEmail(Map<String, String> verifyEmailDto) async {
    return await httpInstance.post(
      "${AppSecrets.serverUrl}/auth/verify-email",
      data: verifyEmailDto,
    );
  }

  Future<Response> checkCredential(String credential) async {
    return await httpInstance.post(
      "${AppSecrets.serverUrl}/auth/check-credential",
      data: {
        "credential": credential
      },
    );
  }

  Future<Response> login(Map<String, String> loginDto) async {
    return await httpInstance.post("${AppSecrets.serverUrl}/auth/login", data: loginDto);
  }

  Future<Response> forgotPassword(String credential) async {
    return await httpInstance.post(
      "${AppSecrets.serverUrl}/auth/forgot-password",
      data: {
        "credential": credential
      },
    );
  }

  Future<Response> confirmPasswordResetCode(String code) async {
    return await httpInstance.post(
      "${AppSecrets.serverUrl}/auth/forgot-password/confirm",
      data: {
        "code": code
      },
    );
  }

  Future<Response> resetPassword(Map<String, String> resetPasswordDto) async {
    return await httpInstance.post("${AppSecrets.serverUrl}/auth/forgot-password/reset", data: resetPasswordDto);
  }

  Future<Response> updateProfilePicture(String picture) async {
    return await httpInstance.put(
      "${AppSecrets.serverUrl}/user/profile-picture",
      data: {
        "picture": picture,
      },
      options: await getDefaulNetworkOptions(),
    );
  }

  Future<Response> getUser() async {
    return await httpInstance.get(
      "${AppSecrets.serverUrl}/user",
      options: await getDefaulNetworkOptions(),
    );
  }
}
