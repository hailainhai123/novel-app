import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:novel_app_client/binding/app_binding.dart';
import 'package:novel_app_client/navigation/main_page.dart';
import 'package:novel_app_client/pages/details_page/comments_page/comments_page.dart';
import 'package:novel_app_client/pages/details_page/list_chap/list_chap_page.dart';
import 'package:novel_app_client/pages/details_page/reading_page/reading_page.dart';
import 'package:novel_app_client/pages/home/home_page.dart';
import 'package:novel_app_client/pages/login/login_page.dart';
import 'package:novel_app_client/pages/register/register_page.dart';
import 'package:novel_app_client/pages/search_page/search_page.dart';
import 'package:novel_app_client/pages/user_page/edit_profile/edit_profile.dart';

import '../pages/details_page/details_page.dart';
import '../pages/grid_page/grid_novel_page.dart';
import '../pages/notification_page/notification_page.dart';
import '../pages/user_page/edit_profile/edit_profile_controller.dart';

const kRouteIndex = "/";
const kHomePage = '/home';
const kSearchPage = '/search';
const kBookDetails = '/book_details/:id';
const kReadingPage = '/reading/:id';
const kListChapPage = '/list_chap/:id';
const kLoginPage = '/login';
const kRegisterPage = '/register';
const kCommentsPage = '/comments/:id';
const kNotificationPage = '/notification';
const kGridNovelPage = '/grid_novel';
const kEditPage = '/edit';

final indexPage = GetPage(
    name: kRouteIndex,
    page: () => MainPage(),
    bindings: [GlobalBinding(), HomeBinding()]);

final homePage = GetPage(name: kHomePage, page: () => HomePage(), bindings: []);

//Book details
final detailsPage = GetPage(
    name: kBookDetails,
    page: () => BookDetailsPage(),
    binding: BookDetailsBinding());

final readingPage = GetPage(
    name: kReadingPage,
    page: () => ReadingPage(),
    binding: BookDetailsBinding());

final commentsPage = GetPage(
    name: kCommentsPage,
    page: () => CommentsPage(),
    binding: CommentsBinding());

//Search
final searchPage = GetPage(
    name: kSearchPage,
    page: () => const SearchPage(),
    bindings: [SearchBinding()]);

//List Chapter
final listChapPage = GetPage(name: kListChapPage, page: () => ListChapPage());

//Login, register
final loginPage = GetPage(name: kLoginPage, page: () => const LoginPage());

final registerPage = GetPage(name: kRegisterPage, page: () => RegisterPage());

//Notification
final notificationPage =
    GetPage(name: kNotificationPage, page: () => const NotificationsPage());

//Notification
final girdNovelPage = GetPage(
  name: kGridNovelPage,
  page: () => const GridNovelPage(),
  maintainState: true,
  // binding: GridPageBinding()
);

final editPage = GetPage(
    name: kEditPage,
    page: () => EditProfilePage(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => EditProfileController());
    }));

final List<GetPage> pages = [
  indexPage,
  homePage,
  searchPage,
  listChapPage,
  detailsPage,
  readingPage,
  loginPage,
  registerPage,
  commentsPage,
  notificationPage,
  girdNovelPage,
  editPage
];
