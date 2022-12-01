import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:novel_app_client/pages/details_page/reading_page/reading_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../constant/theme.dart';

class ListChapReading extends GetView<ReadingController> {
  const ListChapReading({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.itemScrollController
          .jumpTo(index: controller.state!.number! - 1);
    });

    return Container(
      height: 200,
      width: 160,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ScrollablePositionedList.builder(
          itemScrollController: controller.itemScrollController,
          itemPositionsListener: controller.itemPositionsListener,
          itemCount: controller.lastChapter.value,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                controller.showListChap.value = false;
                // Navigator.pop(context);
                controller.changeChapter(index + 1);
                Get.back();
              },
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Chương ${index + 1}',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: controller.state!.number! - 1 == index
                            ? kPrimaryColor
                            : Colors.black)),
              )),
            );
          }),
    );
  }
}
