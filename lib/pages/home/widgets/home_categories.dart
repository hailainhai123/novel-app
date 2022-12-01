import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'package:flutter_shimmer_widget/templates_shimmer_widget.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/constant/routes.dart';
import 'package:novel_app_client/pages/home/home_controller.dart';
import 'package:novel_app_client/stl_widgets/image_network.dart';

import '../../../constant/api_url.dart';
import '../../../constant/theme.dart';

class HomeCategories extends GetView<HomeController> {
  const HomeCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SliverToBoxAdapter(
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.isLoadingCategories.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 40,
                          child: FlutterShimmnerLoadingWidget(
                            count: 2,
                            animate: true,
                            color: Colors.grey[200],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 40,
                        width: Get.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 40,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.listCategories.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        controller.selectCategory(index,
                                            controller.listCategories[index]);
                                      },
                                      child: Obx(() {
                                        return Container(
                                          margin: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: controller
                                                                  .currentCategoryIndex
                                                                  .value ==
                                                              index
                                                          ? kPrimaryColor
                                                          : Colors.transparent,
                                                      width: 2))),
                                          alignment: Alignment.center,
                                          child: Text(
                                            controller.listCategories[index]
                                                    .name ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: controller
                                                            .currentCategoryIndex
                                                            .value ==
                                                        index
                                                    ? Colors.black
                                                    : kGreyColor),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(kGridNovelPage, parameters: {
                                  'title': controller
                                          .listCategories[controller
                                              .currentCategoryIndex.value]
                                          .name ??
                                      "",
                                  'url':
                                      "${ApiURL.gridNovelUrl}${controller.listCategories[controller.currentCategoryIndex.value].id}/book"
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text('Xem thêm >>',
                                    style: TextStyle(color: kPrimaryColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 16),
                controller.isLoadingCategories.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CardPlaceHolderWithAvatar(
                          height: 250,
                        ),
                      )
                    : SizedBox(
                        height: context.isPhone ? 250 : 360,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.listNovelInCate.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // controller.selectCategory(index);
                                Get.toNamed(
                                    "/book_details/${controller.listNovelInCate[index].id}");
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  // color: Colors.red,
                                  height: 220,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width / 3.6,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: NetWorkImageApp(
                                              urlImage: controller
                                                      .listNovelInCate[index]
                                                      .cover?[0]
                                                      .url ??
                                                  "",
                                            )),
                                      ),
                                      SizedBox(
                                        width: width / 3.6,
                                        child: Text(
                                          controller.listNovelInCate[index]
                                                  .name ??
                                              '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        '${controller.listNovelInCate[index].totalViews} lượt xem',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: kGreyColor),
                                      ),
                                    ],
                                  )),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
