import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/constant/styles.dart';
import 'package:novel_app_client/constant/theme.dart';
import 'package:simple_tags/simple_tags.dart';

import '../search_controller.dart';

class RecentSearchWidget extends GetView<SearchController> {
  const RecentSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Gần đây', style: Styles.titleTextStyles),
                GestureDetector(
                    onTap: () {
                      controller.isEditRecent.value =
                          !controller.isEditRecent.value;
                    },
                    child: Obx(() => Text(
                        controller.isEditRecent.value ? "Xong" : "Chỉnh sửa",
                        style: const TextStyle(color: kPrimaryColor))))
              ],
            ),
          ),
          Obx(() {
            return SimpleTags(
                content: controller.listRecentSearch.value,
                wrapSpacing: 4,
                wrapRunSpacing: 4,
                tagContainerPadding: const EdgeInsets.all(6),
                onTagPress: (val) {
                  if (controller.isEditRecent.value) {
                    controller.removeRecent(val);
                  } else {
                    EasyLoading.show();
                    controller.searchNovel(val);
                  }
                },
                tagTextStyle: const TextStyle(color: kPrimaryColor),
                tagIcon: controller.isEditRecent.value
                    ? const Icon(
                        Icons.clear,
                        size: 12,
                        color: kPrimaryColor,
                      )
                    : null,
                tagContainerDecoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.15),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    )));
          })
        ],
      ),
    );
  }
}
