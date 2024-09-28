import 'dart:io';

import 'package:client/shared/constants/secrets.dart';
import 'package:client/shared/utils/network.dart';
import 'package:dio/dio.dart';

class TweetService {
  final httpService = Dio();

  Future<Response> getGifs(String? search) async {
    return await httpService.get("${AppSecrets.serverUrl}/gifs?page=1&limit=20${search != null ? "&search=$search" : ""} ");
  }

  Future<Response> uploadMedia(File file) async {
    final formData = await FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
    });

    return await httpService.post(
      '${AppSecrets.serverUrl}/media',
      data: formData,
      options: await getDefaulNetworkOptions(
        otherOptions: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );
  }

  Future<Response> createTweet(Map<String, dynamic> data) async {
    return await httpService.post(
      '${AppSecrets.serverUrl}/tweets',
      data: data,
      options: await getDefaulNetworkOptions(),
    );
  }

  Future<Response> getUserTweets(String userId) async {
    return await httpService.get(
      "${AppSecrets.serverUrl}/tweets/user/$userId",
      options: await getDefaulNetworkOptions(),
    );
  }

  Future<Response> getHomeTweets() async {
    return await httpService.get(
      "${AppSecrets.serverUrl}/tweets/home",
      options: await getDefaulNetworkOptions(),
    );
  }
}
