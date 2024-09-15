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

  Future<Response> getSuggestedUsers() async {
    return await httpInstance.get(
      "${AppSecrets.serverUrl}/follow/suggested",
      options: await getDefaulNetworkOptions(),
    );
  }

  Future<Response> followUser(String userId) async {
    return await httpInstance.post(
      "${AppSecrets.serverUrl}/follow/user/$userId/follow",
      options: await getDefaulNetworkOptions(),
    );
  }

  Future<Response> unFollowUser(String userId) async {
    return await httpInstance.delete(
      "${AppSecrets.serverUrl}/follow/user/$userId/unfollow",
      options: await getDefaulNetworkOptions(),
    );
  }
}
