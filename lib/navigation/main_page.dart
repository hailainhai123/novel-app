import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/pages/bookmark_page/bookmark_page.dart';
import 'package:novel_app_client/pages/home/home_page.dart';
import 'package:novel_app_client/pages/search_page/search_page.dart';
import 'package:novel_app_client/pages/user_page/user_page.dart';

import 'navigation_bar.dart';
import 'navigation_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final pages = [
    const HomePage(),
    const SearchPage(),
    BookmarkPage(),
    UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Obx(() {
        return pages[navController.currentIndex.value];
      }),
      bottomNavigationBar: NavigationBottomBar(),
    );
  }
}
