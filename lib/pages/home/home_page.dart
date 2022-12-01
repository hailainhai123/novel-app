import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/arbe_module/api/custom_log.dart';
import 'package:novel_app_client/constant/icons_path.dart';
import 'package:novel_app_client/constant/theme.dart';
import 'package:novel_app_client/pages/home/home_controller.dart';
import 'package:novel_app_client/pages/home/widgets/home_arrival.dart';
import 'package:novel_app_client/pages/home/widgets/home_categories.dart';
import 'package:novel_app_client/pages/home/widgets/home_hot_novel.dart';
import 'package:novel_app_client/pages/home/widgets/home_notification_widget.dart';
import 'package:novel_app_client/pages/home/widgets/home_other_novel.dart';
import 'package:novel_app_client/pages/home/widgets/home_top_rate_novel.dart';
import 'package:novel_app_client/pages/home/widgets/last_reading_widget.dart';
import 'package:novel_app_client/stl_widgets/image_network.dart';
import 'package:novel_app_client/utils/global_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: kPrimaryColor));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Get.find<GlobalController>().userLogin.value) {
        controller.loadingLasRead.value = true;
        controller.getLastReading();
      }
    });

    return Stack(children: [
      Obx(() => AnimatedContainer(
          height: controller.bgHeight.value,
          width: double.infinity,
          duration: const Duration(milliseconds: 250),
          child: Image.asset(IconsPath.appbarHomeImage, fit: BoxFit.fitWidth))),
      RefreshIndicator(
        onRefresh: () async {
          controller.initData();
        },
        child: CustomScrollView(
          controller: controller.scrollController,
          slivers: <Widget>[
            const SliverToBoxAdapter(
                child: Padding(padding: EdgeInsets.only(top: 120))),
            const LastReadingWidget(),
            const SliverToBoxAdapter(
                child: Padding(padding: EdgeInsets.only(top: 24))),
            SliverToBoxAdapter(child: Obx(() {
              return Container(
                  height: context.isPhone ? 120 : 240,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TabBarView(
                    controller: controller.tabController,
                    children: controller.listImage
                        .asMap()
                        .map((index, value) => MapEntry(
                            index,
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: NetWorkImageApp(
                                  urlImage: value.image?[0].url ?? ""),
                            )))
                        .values
                        .toList(),
                  ));
            })),
            const HomeTopNovel(),
            const HomeCategories(),
            const HomeArrivals(),
            const HomeHotNovels(),
            const HomeOtherNovels(),
            const SliverPadding(padding: EdgeInsets.only(bottom: 60)),
          ],
        ),
      ),
      const HomeNotificationWidget(),
    ]);
  }
}
