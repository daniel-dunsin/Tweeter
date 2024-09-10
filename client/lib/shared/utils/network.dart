import 'package:client/app.dart';
import 'package:client/config/routes.dart';
import 'package:client/shared/constants/localstorage.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/localstorage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

Future? handleError({
  required Object e,
  bool navigateOnSessionExpired = true,
}) async {
  print(e);
  String errorMessage = "Oops! an error occured";
  if (e is DioException) {
    if (e.response != null) {
      if (e.response?.statusCode == 403) {
        errorMessage = "Session Expired! Login Again";
        navigatorKey.currentState?.pushNamedAndRemoveUntil(AuthRoutes.login, (route) => false);
        await LocalStorage.removeEntry(key: localStorageConstants.user);
        await LocalStorage.removeEntry(key: localStorageConstants.accessToken);
      } else {
        errorMessage = e.response?.data["error"] ?? e.message;
      }
      print(
        "Request failed with status code : ${e.response?.statusCode} - ${e.response?.data}",
      );
    } else {
      errorMessage = e.message ?? e.toString();
    }
  } else {
    errorMessage = e.toString();
  }

  toastification.show(
    closeOnClick: true,
    icon: Icon(Icons.error, color: Colors.white),
    backgroundColor: Color.fromRGBO(255, 0, 0, 1),
    foregroundColor: Colors.white,
    title: Text(
      errorMessage,
      style: TextStyle(fontSize: 12),
    ),
    alignment: Alignment.topCenter,
    dismissDirection: DismissDirection.vertical,
    autoCloseDuration: const Duration(seconds: 2),
    showProgressBar: false,
    closeButtonShowType: CloseButtonShowType.none,
    dragToClose: true,
  );
}

handleSuccess(String message) {
  toastification.show(
    closeOnClick: true,
    icon: Icon(Icons.check_circle_outlined, color: TweeterColors.white),
    backgroundColor: const Color.fromARGB(255, 2, 104, 186),
    title: Text(
      message,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: TweeterColors.white,
      ),
    ),
    alignment: Alignment.topCenter,
    dismissDirection: DismissDirection.vertical,
    autoCloseDuration: const Duration(seconds: 2),
    showProgressBar: false,
    closeButtonShowType: CloseButtonShowType.none,
    dragToClose: true,
  );
}

Future<Options> getDefaulNetworkOptions() async {
  final authToken = await LocalStorage.getString(key: localStorageConstants.accessToken);

  return Options(headers: {
    "Authorization": "Bearer $authToken"
  });
}
