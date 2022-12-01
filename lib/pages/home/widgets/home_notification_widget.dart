import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/constant/routes.dart';

import '../../notification_page/notification_controller.dart';

class HomeNotificationWidget extends GetView<NotificationController> {
  const HomeNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(right: 16),
        width: Get.width,
        child: Row(
          children: [
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                Get.toNamed(kNotificationPage);
              },
              child: SizedBox(
                width: 40,
                child: Badge(
                    position: BadgePosition.topStart(top: -10, start: 20),
                    // badgeContent:
                    //     const Text('3', style: TextStyle(color: Colors.white)),
                    child: const Icon(Icons.notifications,
                        shadows: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2,
                          )
                        ],
                        color: Colors.white,
                        size: 32)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
