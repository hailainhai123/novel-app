import 'package:flutter/cupertino.dart';

mixin PaginationScrollMixin {
  ScrollController scroller = ScrollController();

  int currentPage = 1;
  bool hasNextPage = false;
  bool isLoadingMore = false;

  void initScroller() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      scroller.addListener(scrollListeners);
      checkLoadMore();
    });
  }

  Future<void> loadMoreData() async {}

  void clearData() {}

  Future<void> refreshData() async {
    currentPage = 1;
    hasNextPage = false;
  }

  void checkLoadMore() {
    if (scroller.hasClients && scroller.position.extentAfter < 10) {
      if (canLoadMore()) {
        isLoadingMore = true;
        currentPage++;
        loadMoreData();
      }
    }
  }

  bool canLoadMore() => hasNextPage && !isLoadingMore;

  void scrollListeners() {
    if (scroller.position.extentAfter < 50) {
      if (canLoadMore()) {
        isLoadingMore = true;
        currentPage++;
        loadMoreData();
      }
    }
  }
}
