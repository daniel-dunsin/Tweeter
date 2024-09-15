import 'package:client/shared/constants/secrets.dart';
import 'package:client/shared/utils/network.dart';
import 'package:dio/dio.dart';

class SettingsService {
  final httpInstance = Dio();

  Future<Response> deactivateAccount() async {
    return await this.httpInstance.post(
          "${AppSecrets.serverUrl}/auth/account/deactivate",
          options: await getDefaulNetworkOptions(),
        );
  }

  Future<Response> changePassword(Map data) async {
    return await this.httpInstance.post(
          "${AppSecrets.serverUrl}/auth/change-password",
          data: data,
          options: await getDefaulNetworkOptions(),
        );
  }

  Future<Response> signOut() async {
    return await this.httpInstance.get(
          "${AppSecrets.serverUrl}/auth/sign-out",
          options: await getDefaulNetworkOptions(),
        );
  }
}
