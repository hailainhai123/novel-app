import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/pages/details_page/book_details_controller.dart';
import 'package:novel_app_client/pages/details_page/comments_page/comments_page_controller.dart';

import '../comments_page/widget/count_down.dart';

class NovelComment extends GetView<CommentsPageController> {
  const NovelComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.canSendComment.value
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                if (controller.textEditingController.text.isNotEmpty) {
                  controller.postComment();
                }
              },
              child: const Icon(
                Icons.send,
                size: 40,
                color: Colors.white,
              ),
            ),
          )
        : const CountDownTime());
  }
}
