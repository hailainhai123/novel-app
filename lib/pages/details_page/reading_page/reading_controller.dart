import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:novel_app_client/arbe_module/api/api_dio_controller.dart';
import 'package:novel_app_client/constant/theme.dart';
import 'package:novel_app_client/models/comment_model.dart';
import 'package:novel_app_client/pages/details_page/book_details_controller.dart';
import 'package:novel_app_client/utils/global_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../arbe_module/utils/user_pref.dart';
import '../../../models/chapter_model.dart';
import '../../../models/reading_state_model.dart';
import '../../../models/user_infomation.dart';

class ReadingController extends GetxController with StateMixin<ChapterModel> {
  final GlobalController globalController = Get.find();
  final PageController controller = PageController();
  final BookDetailsController bookDetailsController = Get.find();
  var showListChap = false.obs;
  RxInt lastChapter = RxInt(0);
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final UserInformation pref = UserPref().getUser();

  // var currentChap = ChapterModel(index: 1).obs;
  var idChapter = "".obs;

  final focusReading = FocusNode();

  var textColors = [Colors.black, kPrimaryColor, Colors.white].obs;
  var colorChoose = Colors.black.obs;

  var fontSizeText = [14.0, 16.0, 18.0, 20.0, 22.0, 24.0].obs;
  var fontSize = 14.0.obs;

  var showComment = false.obs;

  var listCommentsChap = <CommentModel>[].obs;
  var canSendComment = true.obs;
  late Timer? countdownTimer;
  var myDuration = const Duration(seconds: 20).obs;
  var pageComment = 1.obs;
  final TextEditingController textEditingController = TextEditingController();

  var showNextWidget = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    int last = int.parse(Get.parameters['lastChap'] ?? "0");
    lastChapter.value = last;
    idChapter.value = Get.parameters['id'] ?? '';
    colorChoose = globalController.colorChoose;
    fontSize = globalController.fontSize;
  }

  @override
  void dispose() {
    _searchController.dispose();
    focusReading.dispose();

    super.dispose();
  }

  final _searchController = TextEditingController();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => {});
  }

  void logViewed(String bookId) async {
    await ApiDioController.upViewed(
        bookId: Get.parameters['bookId'] ?? "", chapterId: idChapter.value);
  }

  void showListChapter() {
    showListChap.value = !showListChap.value;
    update();
  }

  void selectChapter(ChapterModel chapter) {
    showListChapter();
  }

  Future getChapterComments() async {
    await ApiDioController.getChapterComment(
            idChapter.value, pageComment.value, 10)
        .then((value) {
      listCommentsChap.value = value;
    });
  }

  void getDetailsChapter() async {
    await ApiDioController.getChapterDetails(idChapter.value)
        .then((ChapterModel? value) {
      if (value == null) {
        change(value, status: RxStatus.error(""));
      } else {
        change(value, status: RxStatus.success());
        logViewed(value.id!);
        if (bookDetailsController.readingState().currentChapter! <
            value.number!) {
          bookDetailsController.readingState.update((val) {
            if (val == null) return;
            val.currentChapter = value.number!;
          });
          bookDetailsController.updateReadingState();
        }
      }
    }).onError((error, stackTrace) {
      change(value, status: RxStatus.error(error.toString()));
    }).catchError((error) {
      change(value, status: RxStatus.error(error));
    });
  }

  void postComment() async {
    bool success = await ApiDioController.postComment(
        content: textEditingController.text, chapterId: idChapter.value);
    if (success) {
      var info =
          UserInformation(avatarUrl: null, displayName: pref.displayName);

      listCommentsChap.insert(
          0,
          CommentModel(
              user: info,
              content: textEditingController.text,
              createdAt: "Bây giờ"));
      textEditingController.text = "";
      canSendComment.value = false;
      startColdDown();
    }
  }

  void startColdDown() {
    myDuration.value = const Duration(seconds: 20);
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setColdDown());
  }

  void setColdDown() {
    const reduceSecondsBy = 1;
    canSendComment.value = false;

    final seconds = myDuration.value.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      canSendComment.value = true;
      countdownTimer!.cancel();
    } else {
      myDuration.value = Duration(seconds: seconds);
    }
  }

  void changeChapter(int number) async {
    change(null, status: RxStatus.loading());
    await ApiDioController.setReadingState(ReadingStateModel(
        bookId: Get.parameters['bookId'], currentChapter: number));
    await ApiDioController.getContentChapterByNumber(
            number, Get.parameters['bookId'] ?? "")
        .then((ChapterModel? value) {
      if (value == null) {
        change(value, status: RxStatus.error(""));
      } else {
        change(value, status: RxStatus.success());
        idChapter.value = value.id!;
        logViewed(value.id!);
      }
    }).onError((error, stackTrace) {
      change(value, status: RxStatus.error(error.toString()));
    }).catchError((error) {
      change(value, status: RxStatus.error(error));
    });
  }

  void saveSetting({Color? color, double? size}) async {
    if (color != null) {
      colorChoose.value = color;
    }
    if (size != null) {
      fontSize.value = size;
    }
    String nameColor = "";
    for (var item in colors.entries) {
      if (item.value == colorChoose.value) {
        nameColor = item.key;
      }
    }
    Map<String, dynamic> setting = {
      "textColor": nameColor,
      "fontSize": fontSize.value
    };
    await ApiDioController.saveSetting(setting);
  }
}
