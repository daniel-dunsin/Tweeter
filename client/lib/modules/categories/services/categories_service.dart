import 'package:client/shared/constants/secrets.dart';
import 'package:client/shared/utils/network.dart';
import 'package:dio/dio.dart';

class CategoriesService {
  final httpInstance = Dio();

  Future<Response> getCategories() async {
    return await httpInstance.get("${AppSecrets.serverUrl}/category");
  }

  Future<Response> updateInterests(List<String> interests) async {
    return await httpInstance.put(
      "${AppSecrets.serverUrl}/user/interests",
      data: {
        "interests": interests
      },
      options: await getDefaulNetworkOptions(),
    );
  }
}
