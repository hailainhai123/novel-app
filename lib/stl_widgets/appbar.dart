import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/constant/icons_path.dart';
import 'package:novel_app_client/constant/theme.dart';

import '../pages/home/home_controller.dart';

SliverAppBar AppBarWidget(
  RxInt curIndexPage,
  RxDouble opacity,
) {
  final HomeController controller = Get.find<HomeController>();

  return SliverAppBar(
    titleSpacing: 8,
    automaticallyImplyLeading: false,
    // backgroundColor: Colors.transparent,
    elevation: 0,
    pinned: true,
    expandedHeight: 180,
    flexibleSpace: FlexibleSpaceBar(
      background: Image.asset(IconsPath.appbarHomeImage,
          fit: BoxFit.fitWidth, cacheWidth: 1284, cacheHeight: 200),
    ),
    title: GestureDetector(
      onTap: () => {},
      child: Obx(() {
        return Opacity(
          opacity: controller.opacity.value,
          child: Container(
              height: 34,
              width: double.infinity,
              color: kPrimaryColor,
              padding: const EdgeInsets.only(left: 16),
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.circular(5),
              // ),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      "Wellcome back User",
                      style:
                          Get.textTheme.bodyText1!.apply(color: Colors.white),
                    )
                  ],
                ),
              )),
        );
      }),
    ),
  );
}
