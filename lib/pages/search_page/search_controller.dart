import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:novel_app_client/arbe_module/api/api_dio_controller.dart';
import 'package:novel_app_client/models/home/new_model/novel_response_model.dart';

class SearchController extends GetxController {
  RxList<String> listRecentSearch = <String>[].obs;
  var listNovelSearch = <NovelResponseModel>[].obs;
  var hasNextPage = true.obs;
  final box = GetStorage();
  var page = 1.obs;
  var searched = false.obs;
  var isEditRecent = false.obs;
  var isLoading = true.obs;
  var topNovelSearch = <NovelResponseModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void loadRecentSearch() {
    listRecentSearch.clear();
    var recentSearch =
        box.read('recent') == null ? [] : box.read('recent') as List<dynamic>;
    for (var item in recentSearch) {
      listRecentSearch.add(item.toString());
    }
  }

  void searchNovel(String text) async {
    if (!listRecentSearch.contains("$text   ")) {
      listRecentSearch.add("$text   ");
      box.write('recent', listRecentSearch);
    }
    listNovelSearch.value = await ApiDioController.getNovelInSearch(
        hasNextPage: (next) {
          hasNextPage.value = next;
          if (next) {
            page.value += 1;
          }
        },
        text: text,
        page: page.value);
    searched.value = true;
    EasyLoading.dismiss();
  }

  void loadMore() async {
    listNovelSearch.addAll(await ApiDioController.getNovelInSearch(
        hasNextPage: (next) {
          hasNextPage.value = next;
        },
        text: listRecentSearch.last,
        page: page.value));
  }

  void removeRecent(String value) {
    listRecentSearch.remove(value);
    box.write('recent', listRecentSearch);
  }

  void getTopNovelSearch() async {
    await ApiDioController.getTopNovelSearch().then((data) {
      isLoading.value = false;
      topNovelSearch.value = data;
    });
  }

  void logSearch(String bookId) async {
    await ApiDioController.logSearch(bookId);
  }
}
