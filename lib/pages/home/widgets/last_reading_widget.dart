import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/constant/routes.dart';
import 'package:novel_app_client/pages/home/home_controller.dart';
import 'package:novel_app_client/stl_widgets/image_network.dart';
import 'package:novel_app_client/utils/global_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../constant/theme.dart';
import '../../../stl_widgets/multi_text.dart';

class LastReadingWidget extends GetView<HomeController> {
  const LastReadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalController globalController = Get.find();

    return SliverToBoxAdapter(
        child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 1),
                color: kPrimaryColor.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: -4)
          ]),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Obx(() => globalController.userLogin.value
              ? controller.loadingLasRead.value
                  ? const SizedBox(
                      height: 120,
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    )
                  : controller.lastReadChapter.value != 0
                      ? logonWidget()
                      : noLastReading()
              : requireLoginWidget())
        ],
      ),
    ));
  }

  Widget noLastReading() {
    return InkWell(
      onTap: () {
        Get.toNamed("/book_details/${controller.randomNovel().id}");
      },
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 120,
              child: NetWorkImageApp(
                  urlImage: controller.randomNovel().cover?[0].url ?? ""),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${controller.randomNovel().name}',
                  style: const TextStyle(fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                    child: Text(
                  '${controller.randomNovel().shortDescription}',
                  style: const TextStyle(color: kGreyColor),
                  maxLines: 3,
                )),
                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${controller.randomNovel().totalViews}',
                      style: const TextStyle(color: kPrimaryColor),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget logonWidget() {
    int percent = ((controller.lastReadChapter.value /
                controller.totalChapterLastBook.value) *
            100)
        .round();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tiếp tục',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
            Text(percent == 100 ? "Đã đọc xong" : "$percent% hoàn thành",
                style: const TextStyle(
                    color: kGreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600))
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: LinearPercentIndicator(
              // width: 140.0,
              padding: EdgeInsets.zero,
              lineHeight: 5,
              barRadius: const Radius.circular(2.5),
              percent: controller.lastReadChapter.value /
                  controller.totalChapterLastBook.value,
              backgroundColor: kPrimaryColor.withOpacity(0.15),
              progressColor: kPrimaryColor),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed("/book_details/${controller.lastBook.value.id}");
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 60,
                    width: 52,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: NetWorkImageApp(
                          urlImage:
                              controller.lastBook.value.cover![0].url ?? ""),
                    )),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${controller.lastBook.value.name}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      MultiText(firstText: "Chương ", child: [
                        TextSpan(
                            text: "${controller.lastReadChapter.value}",
                            style: const TextStyle(color: kPrimaryColor)),
                        TextSpan(
                            text:
                                ' của ${controller.totalChapterLastBook.value}',
                            style: const TextStyle(
                                color: kGreyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600))
                      ])
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget requireLoginWidget() {
    return Column(
      children: [
        const Text('Đăng nhập để sử dụng tất cả chức năng '),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: double.maxFinite,
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(kLoginPage);
                },
                child: const Text('Đăng nhập')),
          ),
        )
      ],
    );
  }
}
