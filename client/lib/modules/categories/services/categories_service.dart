import 'package:client/shared/constants/secrets.dart';
import 'package:dio/dio.dart';

class CategoriesService {
  final httpInstance = Dio();

  Future<Response> getCategories() async {
    return await httpInstance.get("${AppSecrets.serverUrl}/category");
  }
}
