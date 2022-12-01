import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/pages/search_page/search_controller.dart';
import 'package:novel_app_client/pages/search_page/widgets/recent_search_widget.dart';
import 'package:novel_app_client/pages/search_page/widgets/search_field.dart';
import 'package:novel_app_client/pages/search_page/widgets/top_book_search.dart';
import 'package:novel_app_client/stl_widgets/image_network.dart';
import 'package:novel_app_client/utils/global_controller.dart';
import '../../constant/styles.dart';
import '../../constant/theme.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Get.find<GlobalController>().userLogin.value) {
        controller.loadRecentSearch();
        controller.searched.value = false;
      }
      controller.getTopNovelSearch();
    });

    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => controller.searched.value
                ? CustomScrollView(
                    slivers: [
                      SearchFieldWidget(),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(controller.listNovelSearch.isEmpty
                              ? 'Không tìm thấy truyện với "${controller.listRecentSearch.last.trim()}"'
                              : "Kết quả tìm kiếm của \" ${controller.listRecentSearch.last.trim()} \":"),
                        ),
                      ),
                      controller.listNovelSearch.isEmpty
                          ? const SliverToBoxAdapter()
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      controller.logSearch(controller
                                          .listNovelSearch[index].id!);
                                      Get.toNamed(
                                          "/book_details/${controller.listNovelSearch[index].id}");
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.all(15),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        height: 120,
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            NetWorkImageApp(
                                                urlImage: controller
                                                    .listNovelSearch[index]
                                                    .cover![0]
                                                    .url!),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${controller.listNovelSearch[index].name}",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Flexible(
                                                      child: Text(
                                                    '${controller.listNovelSearch[index].shortDescription}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    "${controller.listNovelSearch[index].totalViews} lượt xem",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: kGreyColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                childCount: controller
                                    .listNovelSearch.length, // 1000 list items
                              ),
                            ),
                    ],
                  )
                : CustomScrollView(slivers: [
                    SearchFieldWidget(),
                    const SliverToBoxAdapter(child: RecentSearchWidget()),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child:
                            Text('Top tìm kiếm', style: Styles.titleTextStyles),
                      ),
                    ),
                    const TopBookSearch()
                  ]))));
  }
}
