import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/models/chapter_model.dart';
import 'package:novel_app_client/models/list_chap_model.dart';

import '../../../arbe_module/api/api_dio_controller.dart';

class ListChapController extends GetxController with StateMixin<ListChapModel> {
  var bookId = "".obs;
  var listChapter = <ListChapModel>[].obs;
  final formKey = GlobalKey<FormState>();
  var loadMore = true.obs;
  var page = 1.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getListChapter();
  }

  void getListChapter() async {
    listChapter.clear();
    listChapter.value = await ApiDioController.getListChapter(
        bookId.value, page.value, nextPage: (hasNextPage) {
      if (hasNextPage) {
        page.value += 1;
      }
      loadMore.value = hasNextPage;
    });
  }

  void loadMoreChapter() async {
    var list = await ApiDioController.getListChapter(bookId.value, page.value,
        nextPage: (hasNextPage) {
      if (hasNextPage) {
        page.value += 1;
      }
      loadMore.value = hasNextPage;
    });
    listChapter.addAll(list);
  }
}
