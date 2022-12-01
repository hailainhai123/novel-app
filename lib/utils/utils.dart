import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/theme.dart';

class Utils {
  static void showError(String message, String? title) {
    Get.snackbar("Lỗi", message,
        backgroundColor: kErrorColor, colorText: Colors.white);
  }

  static void showSuccess(String message, String? title) {
    Get.snackbar(title ?? "Thông báo", message, backgroundColor: kSuccessColor);
  }

  static double reciprocal(double d) => 1 / d;
}
