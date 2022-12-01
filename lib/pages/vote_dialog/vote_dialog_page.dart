import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/pages/details_page/book_details_controller.dart';

import '../../constant/theme.dart';

class VoteDialogPage extends GetView<BookDetailsController> {
  const VoteDialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        height: 300,
        width: Get.width,
        // margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Hủy',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: kGreyColor)),
                  ),
                  const Text('Đánh giá',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  TextButton(
                    onPressed: () {
                      controller.setReadingSate(false);
                    },
                    child: const Text('Gửi',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: kPrimaryColor)),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: SizedBox(
                  child: Obx(() => RatingBar.builder(
                        initialRating: controller.readingState().rate == null
                            ? 0.0
                            : controller.readingState().rate + .0,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          controller.readingState.update((val) {
                            val!.rate = rating;
                          });
                        },
                      ))),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
