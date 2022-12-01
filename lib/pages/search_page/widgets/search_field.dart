import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/pages/search_page/search_controller.dart';

class SearchFieldWidget extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: TextFormField(
          onFieldSubmitted: (value) {
            controller.searchNovel(value);
          },
          decoration: InputDecoration(
            fillColor: const Color(0xffC4C4C4).withOpacity(0.15),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),
            prefixIcon: const Icon(Icons.search),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: "Nhập tên truyện hoặc tác giả... ",
          )),
    );
  }
}
