import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/values/app_values.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({this.milliseconds = defaultDebounceTimeInMilliSeconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
