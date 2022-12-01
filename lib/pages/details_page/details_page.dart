import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:novel_app_client/constant/theme.dart';
import 'package:novel_app_client/pages/details_page/book_details_controller.dart';
import 'package:novel_app_client/pages/details_page/widgets/book_info_widget.dart';
import 'package:novel_app_client/pages/details_page/widgets/details_comment.dart';
import 'package:novel_app_client/stl_widgets/loading_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_tags/simple_tags.dart';

import '../../constant/api_url.dart';
import 'widgets/description_widget.dart';

class BookDetailsPage extends GetView<BookDetailsController> {
  @override
  Widget build(BuildContext context) {
    controller.id = Get.parameters['id'] ?? "";

    if (!controller.status.isLoading) {
      controller.change(null, status: RxStatus.loading());
      controller.getNovelDetails();
    }
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
                Get.delete<BookDetailsController>();
              },
              child: const Icon(Icons.keyboard_backspace_outlined,
                  color: Colors.black)),
          // you can put Icon as well, it accepts any widget.
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                  onTap: () {
                    controller.bookmark(context);
                  },
                  child: Obx(() => Icon(
                      controller.bookmarked.value
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: kPrimaryColor))),
            ),
          ],
          backgroundColor: Colors.white,
          title: const Text("Chi tiết",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getNovelDetails();
            controller.getNovelComments();
          },
          child: controller.obx(
              (state) => SafeArea(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Column(
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              children: [
                                BookInfoWidget(),
                                DescriptionWidget(
                                    title: 'Nội dung',
                                    description:
                                        controller.state?.description ?? ""),
                                const DetailsComment(),
                                DescriptionWidget(
                                  title: "Tag",
                                  description: "",
                                  child: SimpleTags(
                                      tagContainerPadding:
                                          const EdgeInsets.all(6),
                                      wrapSpacing: 4,
                                      wrapRunSpacing: 4,
                                      content: controller.state!.tags!
                                          .map((element) => element)
                                          .toList(),
                                      onTagPress: (value) {
                                        Get.toNamed("/grid_novel", parameters: {
                                          'title': value,
                                          'url':
                                              "${ApiURL.novelInTagUrl}?tags=$value"
                                        });
                                      },
                                      tagContainerDecoration:
                                          const BoxDecoration(
                                              color: Color(0xffefefef),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ))),
                                )
                              ],
                            ),
                          )),
                          const SizedBox(height: 8),
                          SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                                  onPressed: () async {
                                    controller.readNow();
                                  },
                                  child: const Text(
                                    'ĐỌC TRUYỆN',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ))),
                        ],
                      ),
                    ),
                  ),
              onLoading: const LoadingWidget(),
              onEmpty: const Text('Không có dữ liệu'),
              onError: (error) =>
                  Center(child: Text("Đã có lỗi xảy ra $error"))),
        ));
  }
}
