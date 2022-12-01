import 'package:flutter/foundation.dart';

class CustomLog {
  static log(Object? object) {
    if (!kReleaseMode) {
      print(object);
    }
  }
}