import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shimmer_widget/templates_shimmer_widget.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/constant/api_url.dart';
import 'package:novel_app_client/constant/theme.dart';
import 'package:novel_app_client/pages/home/home_controller.dart';
import 'package:novel_app_client/stl_widgets/image_network.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

import '../../../constant/icons_path.dart';
import '../../../constant/routes.dart';

class HomeTopNovel extends GetWidget<HomeController> {
  const HomeTopNovel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Obx(() => controller.topNovel.value.id == null
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      // print(controller.topNovel.value.id);
                      Get.toNamed(
                          "/book_details/${controller.topNovel.value.id}");
                    },
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('TRUYỆN ĐỀ CỬ',
                                    style: TextStyle(
                                        color: Color(0xff19191B),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed("/grid_novel", parameters: {
                                      'title': 'TRUYỆN ĐỀ CỬ',
                                      'url': ApiURL.topNovelUrl
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
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            32 * 5 / 2,
                                    height:
                                        MediaQuery.of(context).size.width / 2 -
                                            32,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: NetWorkImageApp(
                                          urlImage: controller.topNovel.value
                                                  .cover?[0].url ??
                                              ""),
                                    )),
                                Expanded(
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width / 2 -
                                            32 * 160 / 243,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              controller.topNovel.value.name ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500)),
                                          Text(
                                              '${controller.topNovel.value.totalViews} Lượt xem',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: kGreyColor)),
                                          Flexible(
                                              child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Text(
                                                '${controller.topNovel.value.shortDescription}'),
                                          )),
                                          SizedBox(
                                            height: 24,
                                            child: Row(
                                              children: [
                                                RatingStars(
                                                  editable: false,
                                                  rating: controller.topNovel
                                                              .value.rate ==
                                                          null
                                                      ? 0.0
                                                      : controller.topNovel
                                                          .value.rate!.avg!
                                                          .toDouble(),
                                                  color: Colors.amber,
                                                  iconSize: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))));
  }

  double reciprocal(double d) => 1 / d;
}
