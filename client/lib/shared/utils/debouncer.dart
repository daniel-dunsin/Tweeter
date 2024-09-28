import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  Timer? timer;

  Debouncer({this.milliseconds = 2000});

  void run(VoidCallback action) {
    if (timer != null) {
      timer?.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
