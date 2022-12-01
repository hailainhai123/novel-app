import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/arbe_module/api/custom_log.dart';
import 'package:novel_app_client/models/banner/banner_image_model.dart';
import 'package:novel_app_client/models/banner/model_banner.dart';
import 'package:novel_app_client/models/home/new_model/categories_novel_model.dart';
import '../../arbe_module/api/api_dio_controller.dart';
import '../../models/home/new_model/novel_response_model.dart';
import '../../navigation/navigation_controller.dart';
import '../../utils/global_controller.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final RxDouble opacity = 0.0.obs;
  var currentCategoryIndex = 0.obs;
  final RxDouble bgHeight = kBgHeight.obs;
  late ScrollController scrollController;
  late TabController tabController;

  // final ScrollController scrollController = ScrollController();
  var listImage = <BannerModel>[].obs;
  int currentIndex = 0;
  var listArrivals = <NovelResponseModel>[].obs;
  var listHot = <NovelResponseModel>[].obs;
  var topNovel = NovelResponseModel().obs;
  var isLoadingCategories = true.obs;
  var listCategories = <CategoriesNovelModel>[].obs;
  var listNovelInCate = <NovelResponseModel>[].obs;
  var listTopCommentNovel = <NovelResponseModel>[].obs;
  var page = 1;
  var isLoadMore = true.obs;
  var loadingLasRead = true.obs;
  var lastReadChapter = 0.obs;
  var totalChapterLastBook = 0.obs;
  var lastBook = NovelResponseModel().obs;
  var randomNovel = NovelResponseModel().obs;
  late Timer timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController = ScrollController();
    timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (currentIndex < tabController.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      tabController.animateTo(
        currentIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    initData();
  }

  @override
  void onReady() {
    super.onReady();
    bgHeight.value = 200.0;
    scrollController.addListener(onScrolling);
  }

  refreshController() {
    bgHeight.value = 200.0;
    scrollController.dispose();
    scrollController = ScrollController();
    scrollController.addListener(onScrolling);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    scrollController.dispose();
  }

  Future initData() async {
    loadingLasRead.value = true;
    tabController = TabController(length: listImage.length, vsync: this);
    await fetchBannerImage();
    await getTopNovels();
    await getCategories();
    await getArrivals();
    await getHotNovels();
    await getTopCommentNovels();
    Get.find<GlobalController>().userLogin.isTrue ? getLastReading() : null;
  }

  refreshTimer() {
    timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (!timer.isActive) {
        if (currentIndex < tabController.length - 1) {
          currentIndex++;
        } else {
          currentIndex = 0;
        }
        tabController.animateTo(
          currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  Future fetchBannerImage() async {
    var list = await ApiDioController.getBanners();
    listImage.addAll(list);
    tabController = TabController(length: listImage.length, vsync: this);
  }

  Future getArrivals() async {
    listArrivals.clear();
    var list = await ApiDioController.getArrivals();
    listArrivals.addAll(list);
  }

  Future getHotNovels() async {
    listHot.clear();
    var list = await ApiDioController.getHotNovels();
    listHot.addAll(list);
  }

  Future getTopNovels() async {
    var top = await ApiDioController.getTopNovel();
    topNovel.value = top;
  }

  Future getTopCommentNovels() async {
    listTopCommentNovel.clear();
    var list = await ApiDioController.getTopCommentNovel(page,
        isNextPage: (isNextPage) {
      // if (isNextPage) {
      //   page += 1;
      // }
      // isLoadMore.value = isNextPage;
    });
    listTopCommentNovel.addAll(list);
  }

  Future getLastReading() async {
    await ApiDioController.getLastReading().then((data) {
      if (data['message'] == null && data['message'] != "success") {
        lastReadChapter.value = data['currentChapter'];
        totalChapterLastBook.value = data['totalChapters'];
        lastBook.value = NovelResponseModel.fromJson(data['bookDetail']);
      }
      loadingLasRead.value = false;
      if (listHot.length < 2) return;
      randomNovel.value = listHot[Random().nextInt(listHot.length)];
    });
  }

  Future loadMoreItem() async {
    var list = await ApiDioController.getTopCommentNovel(page,
        isNextPage: (isNextPage) {
      if (isNextPage) {
        page += 1;
      }
      isLoadMore.value = isNextPage;
    });
    listTopCommentNovel.addAll(list);
  }

  Future getCategories() async {
    var data = await ApiDioController.getCategories();
    listCategories.value = data;
    await getNovelInCate();
  }

  Future getNovelInCate() async {
    var data = await ApiDioController.getNovelInCate(listCategories[0].id!);
    listNovelInCate.value = data;
    isLoadingCategories.value = false;
  }

  onScrolling() {
    calculateBgHeight();
    calculateAppbarOpacity();
  }

  calculateAppbarOpacity() {
    double opa = (1 - 0.006 * scrollController.offset).clamp(0.0, 1.0);
    opacity.value = 1 - opa;
  }

  calculateBgHeight() {
    bgHeight.value =
        (kBgHeight - scrollController.offset).clamp(0.0, kBgHeight);
  }

  void selectCategory(int index, CategoriesNovelModel cate) async {
    currentCategoryIndex.value = index;
    var data = await ApiDioController.getNovelInCate(cate.id!);
    listNovelInCate.value = data;
  }
}
