import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/chapter.dart';

import '../reading_controller.dart';

class SlideReadTypeWidget extends GetView<ReadingController> {
  const SlideReadTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        // color: Colors.red,
        decoration: BoxDecoration(
            color: controller.colorChoose.value == Colors.white
                ? Colors.black
                : Colors.white,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.only(left: 8),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            '${controller.state?.content}',
            style: TextStyle(
                color: controller.colorChoose.value,
                fontSize: controller.fontSize.value),
          ),
        )),
      ),
    );
  }
}
