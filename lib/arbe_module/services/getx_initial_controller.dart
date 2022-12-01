// import 'package:get/get.dart';
// import 'package:novel_project/controller/controller_daily_mission.dart';
// import 'package:novel_project/controller/controller_user_profile.dart';
// import 'package:novel_project/data/user/local_user_data_controller.dart';
// import 'package:novel_project/screen/bookdetails/controllers/controller_list_chapters.dart';
// import 'package:novel_project/screen/bookdetails/suggestion/controller_novel_suggestion.dart';
// import 'package:novel_project/screen/chapter%20_download/controller/controller_chapters_download.dart';
// import 'package:novel_project/screen/gifts/top/controller_gift_top.dart';
// import 'package:novel_project/screen/gifts/wall/controller/controller_gift_wall.dart';
// import 'package:novel_project/screen/home/controllers/genres_controller.dart';
// import 'package:novel_project/screen/home/controllers/home_controller.dart';
// import 'package:novel_project/screen/ranking_screen/controllers/controller_ranking.dart';
// import 'package:novel_project/screen/recharge-history/controllers/controller_recharge_history.dart';
// import 'package:novel_project/screen/user/earn_rewards/controllers/controller_earn_rewards.dart';
// import 'package:novel_project/screen/voucher_history/controllers/controller_vouchers_history.dart';
//
// class GetXInitialController {
//   static lazyPutAll() {
//     Get.lazyPut(() => ControllerUserInfo());
//     Get.lazyPut(() => ControllerChaptersDownload());
//     Get.lazyPut(() => ControllerListChapters());
//     Get.lazyPut(() => ControllerGiftWall());
//     Get.lazyPut(() => ControllerGiftTop());
//     Get.lazyPut(() => ControllerRechargeHistory());
//     Get.lazyPut(() => ControllerVouchersHistory());
//     Get.lazyPut(() => ControllerDailyMission());
//     Get.lazyPut(() => ControllerNovelSuggestion());
//     Get.lazyPut(() => ControllerRanking());
//     Get.lazyPut(() => ControllerListChapters());
//     Get.lazyPut(() => ControllerEarnReward());
//     Get.lazyPut(() => HomeController());
//     Get.lazyPut(() => GenresController());
//   }
//
//   static init() async {
//     await Get.put<LocalUserDataController>(LocalUserDataController())
//         .loadData();
//   }
// }
