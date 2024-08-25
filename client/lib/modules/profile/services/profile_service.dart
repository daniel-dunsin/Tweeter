import 'package:client/shared/constants/secrets.dart';
import 'package:client/shared/utils/network.dart';
import 'package:dio/dio.dart';

class ProfileService {
  final httpInstance = Dio();

  Future<Response> getUserProfile(String userId) async {
    return await httpInstance.get(
      "${AppSecrets.serverUrl}/user/$userId",
      options: await getDefaulNetworkOptions(),
    );
  }
}
