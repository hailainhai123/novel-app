import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:novel_app_client/arbe_module/utils/user_pref.dart';
import 'package:novel_app_client/models/comment_model.dart';
import 'package:novel_app_client/models/user_infomation.dart';

import '../../../arbe_module/api/api_dio_controller.dart';

class CommentsPageController extends GetxController {
  var size = const Size(double.infinity, 80).obs;
  var listComments = <CommentModel>[].obs;
  var id = "";
  var pageComment = 0.obs;
  final TextEditingController textEditingController = TextEditingController();
  final UserInformation pref = UserPref().getUser();
  late Timer? countdownTimer;
  var myDuration = const Duration(seconds: 20).obs;
  var canSendComment = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    id = Get.parameters['id'] ?? "";
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => {});
    getNovelComments();
  }

  void getNovelComments() async {
    await ApiDioController.getNovelComments(id, pageComment.value, 10)
        .then((value) {
      listComments.value = value;
    });
  }

  void postComment() async {
    bool success = await ApiDioController.postComment(
        content: textEditingController.text, bookId: id);
    if (success) {
      var info =
          UserInformation(avatarUrl: null, displayName: pref.displayName);

      listComments.insert(
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
}
