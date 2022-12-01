import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/pages/home/home_controller.dart';
import 'package:novel_app_client/stf_widget/infinity_list.dart';

import '../../../constant/api_url.dart';
import '../../../constant/routes.dart';
import '../../../constant/theme.dart';

class HomeOtherNovels extends GetView<HomeController> {
  const HomeOtherNovels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Đánh giá cao'.toUpperCase(),
                      style: const TextStyle(
                          color: Color(0xff19191B),
                          fontWeight: FontWeight.w700,
                          fontSize: 16)),
                  InkWell(
                    onTap: () {
                      Get.toNamed(kGridNovelPage, parameters: {
                        'title': 'Đánh giá cao'.toUpperCase(),
                        'url': ApiURL.topCommentNovelUrl,
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
              height: context.isPhone ? 250 : 400,
              child: Obx(() {
                return InfinityList(
                  child: (index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                            "/book_details/${controller.listTopCommentNovel[index].id}");
                      },
                      child: Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: width / 3.6,
                                  height: (width / 3.6) * 3 / 2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl: controller
                                              .listTopCommentNovel[index]
                                              .cover![0]
                                              .url ??
                                          "",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator()),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  )),
                              Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 72,
                                  minHeight: 72,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: width / 3.6,
                                        child: Text(
                                          controller.listTopCommentNovel[index]
                                                  .name ??
                                              "",
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${controller.listTopCommentNovel[index].totalViews} lượt xem",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: kGreyColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    );
                  },
                  length: controller.listTopCommentNovel.length,
                  isLoadMore: true,
                  loadMoreItem: () {
                    controller.loadMoreItem();
                  },
                );
                // return ListView.builder(
                //   shrinkWrap: true,
                //   padding: EdgeInsets.zero,
                //   scrollDirection: Axis.horizontal,
                //   itemCount: controller.listTopCommentNovel.length + 1,
                //   itemBuilder: (context, index) {
                //     if (controller.listTopCommentNovel.length == index) {
                //       return const SizedBox();
                //     }
                //     if (controller.listTopCommentNovel.length == index &&
                //         controller.isLoadMore.value) {
                //       return Container(
                //         color: Colors.grey.shade100,
                //         height: context.isPhone ? 250 : 400,
                //         width: 240,
                //         child: const Center(
                //           child: CircularProgressIndicator(),
                //         ),
                //       );
                //     }
                //     return ;
                //   },
                // );
              }),
            ),
          ],
        ),
      ),
    ));
  }
}
