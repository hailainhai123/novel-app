import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/pages/search_page/search_controller.dart';
import 'package:novel_app_client/stl_widgets/image_network.dart';

import '../../../constant/icons_path.dart';
import '../../../constant/styles.dart';
import '../../../constant/theme.dart';

class TopBookSearch extends GetView<SearchController> {
  const TopBookSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? SliverToBoxAdapter(
            child: Column(
              children: const [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                )
              ],
            ),
          )
        : SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(
                        "/book_details/${controller.topNovelSearch[index].id}");
                  },
                  child: Container(
                    height: 60,
                    width: 40,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        SizedBox(
                            height: 60,
                            width: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: NetWorkImageApp(
                                urlImage: controller
                                        .topNovelSearch[index].cover?[0].url ??
                                    "",
                              ),
                            )),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${controller.topNovelSearch[index].name}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                              controller.topNovelSearch[index].searches != 0
                                  ? Text(
                                      '${controller.topNovelSearch[index].searches} Lượt tìm kiếm',
                                      style: const TextStyle(
                                          fontSize: 12, color: kGreyColor))
                                  : const SizedBox()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              childCount: controller.topNovelSearch.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 3.4,
            ),
          ));
  }
}
