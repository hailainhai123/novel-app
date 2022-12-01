import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:measure_size/measure_size.dart';
import 'package:novel_app_client/constant/theme.dart';
import 'package:novel_app_client/pages/details_page/comments_page/widget/count_down.dart';

import '../../../stf_widget/comment_child.dart';
import 'comments_page_controller.dart';

class CommentsPage extends GetView<CommentsPageController> {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
          title: const Text("Danh sách bình luận"),
          leading: GestureDetector(
            onTap: () {
              Get.back();
              Get.delete<CommentsPageController>();
            },
            child: const Icon(Icons.keyboard_backspace_outlined,
                color: Colors.black),
          )),
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RefreshIndicator(
                            onRefresh: () async {
                              controller.getNovelComments();
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Obx(() => controller.listComments.isEmpty
                                  ? const Center(
                                      child: Text('Chưa có bình luận'))
                                  : Column(
                                      children: controller.listComments
                                          .asMap()
                                          .map((key, value) => MapEntry(key,
                                              CommentChild(comment: value)))
                                          .values
                                          .toList(),
                                    )),
                            )))),
                Obx(() => Container(height: controller.size.value.height))
              ],
            ),
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Container(
                decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    border: Border(top: BorderSide(color: Colors.grey))),
                // height: 80,
                width: double.infinity,
                child: Row(
                  children: [
                    Flexible(
                      child: MeasureSize(
                        onChange: (newSize) {
                          controller.size.value = newSize;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: controller.textEditingController,
                            maxLines: null,
                            // scrollPadding: EdgeInsets.zero,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              hintText: 'Gửi bình luận',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(() => controller.canSendComment.value
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                if (controller
                                    .textEditingController.text.isNotEmpty) {
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
                        : const CountDownTime()),
                    const SizedBox(width: 8)
                  ],
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
