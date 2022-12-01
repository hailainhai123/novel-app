import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:novel_app_client/arbe_module/api/api_dio_controller.dart';

import '../../models/notification_model.dart';

class NotificationController extends GetxController
    with StateMixin<List<NotificationModel>> {
  var page = 1.obs;
  var hasNextPage = true.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getNotifications();
  }

  void getNotifications() async {
    await ApiDioController.getAllNoti(
            hasNextPage: (next) {
              hasNextPage.value = next;
            },
            page: page.value)
        .then((value) {
      change(value, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change(value, status: RxStatus.error("Lỗi bất thường"));
    });
  }
}
