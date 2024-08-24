import 'package:client/shared/constants/secrets.dart';
import 'package:client/shared/utils/network.dart';
import 'package:dio/dio.dart';

class FollowService {
  final httpInstance = Dio();

  Future<Response> getUserFollows(String userId) async {
    return await httpInstance.get(
      "${AppSecrets.serverUrl}/follow/user/$userId",
      options: await getDefaulNetworkOptions(),
    );
  }
}
