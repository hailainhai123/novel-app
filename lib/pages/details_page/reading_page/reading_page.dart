import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:novel_app_client/constant/theme.dart';
import 'package:novel_app_client/pages/details_page/book_details_controller.dart';
import 'package:novel_app_client/pages/details_page/reading_page/reading_controller.dart';
import 'package:novel_app_client/pages/details_page/reading_page/widgets/horizontal_read_type_widget.dart';
import 'package:novel_app_client/pages/details_page/reading_page/widgets/list_chapter_widget.dart';
import 'package:novel_app_client/pages/details_page/reading_page/widgets/slide_read_type_widget.dart';
import 'package:novel_app_client/pages/details_page/reading_page/widgets/vertical_read_type_widget.dart';

import '../../../stl_widgets/loading_widget.dart';
import 'widgets/bottom_dialog.dart';

enum ReadingType { slide, vertical, horizontal }

class ReadingPage extends GetView<ReadingController> {
  final ReadingType readingType = ReadingType.slide;

  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getDetailsChapter();
    });
    return controller.obx(
      (state) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          // backgroundColor: Colors.red,
          appBar: AppBar(
            elevation: 0.5,
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                  Get.find<BookDetailsController>().getReadingState();
                  Get.delete<ReadingController>();
                },
                child: const Icon(Icons.keyboard_backspace_outlined,
                    color: Colors.black)),
            // you can put Icon as well, it accepts any widget.
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                    onTap: () async {
                      await controller.getChapterComments();
                      showBarModalBottomSheet(
                          barrierColor: Colors.black.withOpacity(0.5),
                          context: context,
                          builder: (BuildContext context) {
                            return const BottomModelChapter();
                          });
                    },
                    child: const Icon(Icons.more_vert, color: Colors.black)),
              ),
            ],
            backgroundColor: Colors.white,
            title: Text(Get.parameters['title'] ?? "",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
          body: SafeArea(
              child: Container(
                  // width: 160,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Obx(() => Opacity(
                        opacity: controller.showListChap.value ? 0.1 : 1,
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                                    // padding: EdgeInsets.only(bottom: 40),
                                    child: _renderReadingByType(readingType))),
                            Obx(() => Container(
                                  // height: 30,
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Opacity(
                                            opacity:
                                                state!.number == 1 ? 0.2 : 1,
                                            child: IconButton(
                                                onPressed: () {
                                                  if (state.number == 1) {
                                                    return;
                                                  }
                                                  controller.changeChapter(
                                                      state.number! - 1);
                                                },
                                                icon: const Icon(
                                                    Icons.arrow_back_ios)),
                                          ),
                                          Opacity(
                                            opacity: state.number ==
                                                    controller.lastChapter.value
                                                ? 0.2
                                                : 1,
                                            child: IconButton(
                                                onPressed: () {
                                                  if (state.number ==
                                                      controller.lastChapter
                                                          .value) return;
                                                  controller.changeChapter(
                                                      state.number! + 1);
                                                },
                                                icon: const Icon(
                                                    Icons.arrow_forward_ios)),
                                          )
                                        ],
                                      ),
                                      CupertinoPopoverButton(
                                          onTap: () {
                                            return false;
                                          },
                                          popoverWidth: 200,
                                          popoverHeight: 160,
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth: Get.width * 4 / 6),
                                            child: Text(
                                                'Chương ${controller.state?.number} : ${controller.state?.name}',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: kPrimaryColor)),
                                          ),
                                          popoverBuild: (BuildContext context) {
                                            return const ListChapReading();
                                          }),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      )))),
        ),
      ),
      onLoading: const LoadingWidget(message: "Đang load chapter"),
    );
  }

  Widget _renderReadingByType(ReadingType type) {
    switch (type) {
      case ReadingType.horizontal:
        return const HorizontalReadTypeWidget();
      case ReadingType.vertical:
        return const VerticalReadTypeWidget();
      default:
        return const SlideReadTypeWidget();
    }
  }
}
