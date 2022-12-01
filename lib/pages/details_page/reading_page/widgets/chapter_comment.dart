import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:measure_size/measure_size.dart';
import 'package:novel_app_client/pages/details_page/book_details_controller.dart';
import 'package:novel_app_client/pages/details_page/comments_page/comments_page_controller.dart';
import 'package:novel_app_client/pages/details_page/reading_page/reading_controller.dart';
import 'package:novel_app_client/pages/details_page/reading_page/widgets/chapter_count_time.dart';

import '../../../../constant/theme.dart';
import '../../comments_page/widget/count_down.dart';

class ChapterComment extends GetView<ReadingController> {
  const ChapterComment({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom > 0
                      ? MediaQuery.of(context).viewInsets.bottom
                      : 8),
              child: TextField(
                controller: controller.textEditingController,
                maxLines: null,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white)),
                  hintText: 'Gửi bình luận',
                ),
              ),
            ),
          ),
          Container(
            width: 60,
            padding: const EdgeInsets.only(top: 20),
            child: Obx(() => controller.canSendComment.value
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
                        color: Colors.black,
                      ),
                    ),
                  )
                : const ChapterCountDownTime()),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
