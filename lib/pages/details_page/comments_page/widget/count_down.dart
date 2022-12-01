import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/pages/details_page/comments_page/comments_page_controller.dart';

class CountDownTime extends GetView<CommentsPageController> {
  const CountDownTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String strDigits(int n) => n.toString().padLeft(2, '0');
      return Text(
        ' (${strDigits(controller.myDuration.value.inMinutes.remainder(60))}:${strDigits(controller.myDuration.value.inSeconds.remainder(60))})',
      );
    });
  }
}
