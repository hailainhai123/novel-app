import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/constant/routes.dart';
import 'package:novel_app_client/models/comment_model.dart';
import 'package:novel_app_client/models/home/new_model/novel_response_model.dart';
import 'package:novel_app_client/models/reading_state_model.dart';

import '../../arbe_module/api/api_dio_controller.dart';
import '../../utils/global_controller.dart';
import '../../utils/utils.dart';

class BookDetailsController extends GetxController
    with StateMixin<NovelResponseModel> {
  var bookmarked = false.obs;
  var rate = 0.0.obs;
  var onLoadDetails = true.obs;
  var id = "";
  var pageComment = 1.obs;
  var listComments = <CommentModel>[].obs;
  final readingState = ReadingStateModel(bookId: "", currentChapter: 0).obs;
  final globalController = Get.find<GlobalController>();
  var rating = 0.0.obs;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void onReady() {
    super.onReady();
    getNovelDetails();
    getReadingState();
    getNovelComments();
  }

  void getReadingState() async {
    await ApiDioController.getReadingState(id).then((value) async {
      await getNovelDetails();
      readingState.update((readingState) {
        readingState!.bookId = id;
      });
      if (value == null) {
        return;
      } else {
        readingState.update((val) {
          if (val != null) {
            val.rate = value.rate;
            val.followed = value.followed;
            val.currentChapter = value.currentChapter ?? 0;
            val.lastReadAt = value.lastReadAt;
          }
        });
        bookmarked.value = readingState().followed ?? false;
      }
    });
  }

  Future getNovelDetails() async {
    await ApiDioController.getNovelDetails(id)
        .then((value) => value == null
            ? change(value, status: RxStatus.error(""))
            : change(value, status: RxStatus.success()))
        .onError((error, stackTrace) =>
            change(value, status: RxStatus.error(error.toString())))
        .catchError((error) {
      change(value, status: RxStatus.error(error));
    });
  }

  void getNovelComments() async {
    await ApiDioController.getNovelComments(id, pageComment.value, 2)
        .then((value) {
      listComments.value = value;
    });
  }

  void readNow() async {
    await ApiDioController.getListChapter(id, 1,
            limit: 10000, nextPage: (success) {})
        .then((value) {
      Get.toNamed(
          "/reading/${value[readingState().currentChapter == null || readingState().currentChapter == 0 ? 0 : readingState().currentChapter! - 1].id}",
          parameters: {
            'title': state?.name ?? "",
            'bookId': id,
            'lastChap': value.length.toString()
          });
    });
  }

  void bookmark(BuildContext context) {
    readingState.value.followed = !bookmarked.value;
    globalController.userLogin.value
        ? setReadingSate(true)
        : showDialogLogin(context);
  }

  void setReadingSate(bool isBookmark) async {
    String topic = kReleaseMode ? 'book_$id' : 'book_${id}_dev';
    EasyLoading.show(status: isBookmark ? null : "Đang gửi đánh giá");
    await ApiDioController.setReadingState(readingState()).then((value) async {
      if (value == null) {
        EasyLoading.dismiss();
        return;
      }
      EasyLoading.dismiss();
      if (value['message'] == 'success' && isBookmark) {
        if (bookmarked.value) {
          await messaging.unsubscribeFromTopic(topic);
        } else {
          await messaging.subscribeToTopic(topic);
        }
        bookmarked.value = !bookmarked.value;
      } else {
        Get.back();
        Utils.showSuccess("Đánh giá thành công", "Cám ơn đánh giá của bạn!");
      }

      if (value['message'] == 'success' && !isBookmark) {
        Get.back();
        // rate.value = ratePresent;
      }
    });
  }

  void updateReadingState() async {
    await ApiDioController.setReadingState(readingState());
  }

  void showDialogLogin(BuildContext context) {
    Get.defaultDialog(
        title: "Yêu cầu",
        middleText: 'Đăng nhập để sử dụng tất cả chức năng',
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(kLoginPage);
                  },
                  child: const Text('Đăng nhập')),
              const SizedBox(width: 16),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(kRegisterPage);
                  },
                  child: const Text('Đăng ký')),
            ],
          )
        ]);
  }

// Widget requireLoginWidget() {
//   return Container(
//     height: 200,
//     color: Colors.white,
//     child: IntrinsicHeight(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text('Đăng nhập để sử dụng tất cả chức năng ',
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black)),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                   onPressed: () {}, child: const Text('Đăng nhập')),
//               const SizedBox(width: 16),
//               ElevatedButton(onPressed: () {}, child: const Text('Đăng ký')),
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }
}
