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

  Future<Response> editUserProfile(Map<String, dynamic> editProfileDto) async {
    return await httpInstance.put(
      "${AppSecrets.serverUrl}/user",
      data: editProfileDto,
      options: await getDefaulNetworkOptions(),
    );
  }

  Future<Response> deleteProfilePicture() async {
    return await httpInstance.delete(
      "${AppSecrets.serverUrl}/user/profile-picture",
      options: await getDefaulNetworkOptions(),
    );
  }

  Future<Response> deleteCoverPicture() async {
    return await httpInstance.delete(
      "${AppSecrets.serverUrl}/user/cover-picture",
      options: await getDefaulNetworkOptions(),
    );
  }
}
