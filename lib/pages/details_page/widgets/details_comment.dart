import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:novel_app_client/pages/details_page/book_details_controller.dart';
import 'package:novel_app_client/stf_widget/comment_child.dart';

import 'description_widget.dart';

class DetailsComment extends GetView<BookDetailsController> {
  const DetailsComment({super.key});

  @override
  Widget build(BuildContext context) {
    return DescriptionWidget(
        title: "Bình luận",
        showAll: true,
        show: () {
          Get.toNamed("/comments/${controller.id}");
        },
        description: "",
        child: Obx(() => controller.listComments.isEmpty
            ? const Center(child: Text('Chưa có bình luận'))
            : Column(
                children: controller.listComments
                    .asMap()
                    .map((key, value) =>
                        MapEntry(key, CommentChild(comment: value)))
                    .values
                    .toList(),
              )));
  }
}
