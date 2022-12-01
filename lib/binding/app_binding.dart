import 'package:get/get.dart';
import 'package:novel_app_client/navigation/navigation_controller.dart';
import 'package:novel_app_client/pages/bookmark_page/bookmark_page.dart';
import 'package:novel_app_client/pages/details_page/book_details_controller.dart';
import 'package:novel_app_client/pages/details_page/comments_page/comments_page_controller.dart';
import 'package:novel_app_client/pages/details_page/list_chap/list_chap_controller.dart';
import 'package:novel_app_client/pages/details_page/reading_page/reading_controller.dart';
import 'package:novel_app_client/pages/grid_page/grid_pages_controller.dart';
import 'package:novel_app_client/pages/login/login_controller.dart';
import 'package:novel_app_client/pages/notification_page/notification_controller.dart';
import 'package:novel_app_client/pages/register/register_page.dart';
import 'package:novel_app_client/utils/global_controller.dart';

import '../pages/bookmark_page/bookmark_controller.dart';
import '../pages/home/home_controller.dart';
import '../pages/search_page/search_controller.dart';
import '../pages/user_page/user_controller.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NavController(), permanent: true);
    Get.put(NotificationController(), permanent: true);
    Get.put(LoginController(), permanent: false);
    Get.put(HomeController(), permanent: true);
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
    Get.put(SearchController(), permanent: true);
    Get.put(BookMarkController(), permanent: true);
    Get.put(UserController(), permanent: true);
  }
}

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(() => SearchController());
  }
}

class BookDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookDetailsController());
    Get.lazyPut(() => ReadingController());
  }
}

class CommentsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommentsPageController());
  }
}

class GridPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GridPagesController());
  }
}
