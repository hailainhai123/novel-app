import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/constant/icons_path.dart';
import 'package:novel_app_client/constant/theme.dart';
import 'package:novel_app_client/pages/bookmark_page/bookmark_controller.dart';
import 'package:novel_app_client/utils/global_controller.dart';

import '../../constant/routes.dart';
import '../../stl_widgets/image_network.dart';
import '../../stl_widgets/loading_widget.dart';
import '../../stl_widgets/require_login_widget.dart';

class BookmarkPage extends GetView<BookMarkController> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<GlobalController>().userLogin.value
          ? controller.getListBookMark()
          : null;
    });

    if (Get.find<GlobalController>().userLogin.value) {
      return RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: Colors.blue,
        strokeWidth: 4.0,
        onRefresh: () async {
          controller.getListBookMark();
        },
        // Pull from top to show refresh indicator.
        child: controller.obx(
            (state) => CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      shape: const Border(
                          bottom:
                              BorderSide(color: Color(0xff544d9c), width: 0.5)),
                      elevation: 1,
                      title: Row(
                        children: const [
                          Text('ĐANG THEO DÕI', style: TextStyle(fontSize: 22)),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(
                                  "/book_details/${controller.state![index].id}");
                            },
                            child: Card(
                              margin: const EdgeInsets.all(15),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                height: 160,
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width / 4 - 8,
                                      child: NetWorkImageApp(
                                          urlImage: controller
                                              .state![index].cover![0].url!),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.state![index].name}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '${controller.state![index].shortDescription}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "${controller.state![index].totalViews} lượt xem",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: kGreyColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          controller.setReadingSate(index);
                                        },
                                        child: const Icon(Icons.bookmark,
                                            color: kPrimaryColor)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: controller.state!.length,
                      ),
                    )
                  ],
                ),
            onLoading: const LoadingWidget(),
            onEmpty: const Text('Không có dữ liệu'),
            onError: (error) => Center(child: Text("Đã có lỗi xảy ra $error"))),
      );
    } else {
      return const SafeArea(child: RequireLoginWidget());
    }
  }
}
