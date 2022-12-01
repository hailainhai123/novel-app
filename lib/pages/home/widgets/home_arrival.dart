import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/pages/home/home_controller.dart';

import '../../../constant/api_url.dart';
import '../../../constant/theme.dart';

class HomeArrivals extends GetView<HomeController> {
  const HomeArrivals({Key? key}) : super(key: key);

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
                  const Text('TRUYỆN MỚI',
                      style: TextStyle(
                          color: Color(0xff19191B),
                          fontWeight: FontWeight.w700,
                          fontSize: 16)),
                  InkWell(
                    onTap: () {
                      Get.toNamed("/grid_novel", parameters: {
                        'title': 'TRUYỆN MỚI',
                        'url': ApiURL.arrivalUrl
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
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.listArrivals.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                            "/book_details/${controller.listArrivals[index].id}");
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
                                      imageUrl: controller.listArrivals[index]
                                              .cover![0].url ??
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
                                          controller.listArrivals[index].name ??
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
                                      "${controller.listArrivals[index].totalViews} lượt xem",
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
                );
              }),
            ),
          ],
        ),
      ),
    ));
  }
}
