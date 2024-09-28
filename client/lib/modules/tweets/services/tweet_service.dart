import 'package:client/shared/constants/secrets.dart';
import 'package:dio/dio.dart';

class TweetService {
  final httpService = Dio();

  Future<Response> getGifs(String? search) async {
    return await httpService.get("${AppSecrets.serverUrl}/gifs?page=1&limit=20${search != null ? "&search=$search" : ""} ");
  }
}
