import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/stf_widget/comment_child.dart';
import 'package:novel_app_client/utils/global_controller.dart';

import '../../../../constant/theme.dart';
import '../reading_controller.dart';
import 'chapter_comment.dart';

class BottomModelChapter extends GetView<ReadingController> {
  const BottomModelChapter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => IntrinsicHeight(
          child: Container(
              // margin: const EdgeInsets.symmetric(vertical: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              color: controller.colorChoose.value == Colors.white
                  ? Colors.grey
                  : Colors.white,
              child: Center(
                  child: controller.showComment.value
                      ? _commentsChapWidget()
                      : _settingWidget(context))),
        ));
  }

  Widget _settingWidget(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _chooseSizeText(),
          const SizedBox(height: 16),
          _chooseColor(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    controller.showComment.value = true;
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.mode_comment_rounded),
                      SizedBox(width: 8),
                      Text('Xem bình luận'),
                    ],
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.close),
                      SizedBox(width: 8),
                      Text('Đóng'),
                    ],
                  )),
            ],
          ),
        ]);
  }

  Widget _commentsChapWidget() {
    return SizedBox(
      height: Get.height * 3 / 4,
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    controller.showComment.value = false;
                  },
                  child: const Icon(Icons.keyboard_backspace_outlined,
                      color: Colors.black)),
              Text('Bình luận (${controller.listCommentsChap.length})'),
              const SizedBox(width: 18)
            ],
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16)),
            child: Obx(() => Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: controller.listCommentsChap
                                .asMap()
                                .map((key, value) => MapEntry(
                                    key,
                                    CommentChild(
                                      comment: value,
                                    )))
                                .values
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    const ChapterComment()
                  ],
                )),
          )),
        ],
      ),
    );
  }

  Widget _chooseColor() {
    return SizedBox(
      height: 40,
      child: Row(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text('Màu chữ :', style: TextStyle(color: Colors.black)),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: controller.textColors
                .map((element) => InkWell(
                      onTap: () {
                        controller.saveSetting(color: element);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: element,
                            border: Border.all(
                                color: controller.colorChoose.value == element
                                    ? kPrimaryColor
                                    : Colors.black)),
                      ),
                    ))
                .toList(),
          ),
        )
      ]),
    );
  }

  Widget _chooseSizeText() {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Column(
            children: [
              Expanded(child: Container()),
              const Text('Cỡ chữ :', style: TextStyle(color: Colors.black)),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: controller.fontSizeText
                  .map((element) => InkWell(
                        onTap: () {
                          controller.saveSetting(size: element);
                        },
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Column(
                            children: [
                              Expanded(child: Container()),
                              Text('aA',
                                  style: TextStyle(
                                      fontSize: element,
                                      color:
                                          controller.fontSize.value == element
                                              ? kPrimaryColor
                                              : Colors.black)),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
