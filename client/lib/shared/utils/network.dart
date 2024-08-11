import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

Future? handleError({required Object e}) async {
  String errorMessage = "Oops! an error occured";
  if (e is DioException) {
    if (e.response != null) {
      print(
        "Request failed with status code : ${e.response?.statusCode} - ${e.response?.data}",
      );
    } else {
      errorMessage = e.message ?? "Oops! an error occured";
    }
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
