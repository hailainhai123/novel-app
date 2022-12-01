import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../arbe_module/api/api_dio_controller.dart';
import '../../models/home/new_model/novel_response_model.dart';
import '../../models/reading_state_model.dart';
import '../../utils/utils.dart';

class BookMarkController extends GetxController
    with StateMixin<List<NovelResponseModel>>{
  var bookmarked = false.obs;
  final readingState = ReadingStateModel(bookId: "", currentChapter: 0).obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    // getListBookMark();
    super.onReady();
  }

  void getListBookMark() async {
    await ApiDioController.getListBookMark()
        .then((value) {
      change(value, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change(value, status: RxStatus.error("Lỗi bất thường"));
    });
  }

  void removeBook(int index) {
    // List<NovelResponseModel> listNewBook = <NovelResponseModel>[];
    state!.removeAt(index);
    // listNewBook = state!;
    change(state, status: RxStatus.success());
  }

  void setReadingSate(int index) async {
    EasyLoading.show();
    String? bookId = state![index].id;
    // readingState.value.bookId = bookId;
    // readingState.value.followed = false;
    // readingState.update;
    readingState.update((val) {
      val!.bookId = bookId;
      val.followed = false;
    });
    await ApiDioController.setReadingState(readingState()).then((value) {
      if (value == null) {
        EasyLoading.dismiss();
        return;
      }
      removeBook(index);
      EasyLoading.dismiss();
    });
  }


}