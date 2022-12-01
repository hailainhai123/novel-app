import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:novel_app_client/pages/details_page/list_chap/list_chap_controller.dart';

import '../book_details_controller.dart';

class ListChapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ListChapController controller = Get.put(ListChapController());
    controller.bookId.value = Get.parameters['id'] ?? '';

    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
              Get.delete<ListChapController>();
            },
            child: const Icon(Icons.keyboard_backspace_outlined,
                color: Colors.black)),
        // you can put Icon as well, it accepts any widget.
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
        backgroundColor: Colors.white,
        title: const Text("Danh sách chương",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          // color: Colors.grey,
          child: Column(
            children: [
              // Obx(() => Form(
              //     key: controller.formKey,
              //     child: SearchField(
              //       marginColor: Colors.white,
              //       suggestions: controller.listNameChapter
              //           .map((e) => SearchFieldListItem(e))
              //           .toList(),
              //       suggestionState: Suggestion.hidden,
              //       textInputAction: TextInputAction.next,
              //       hint: '',
              //       hasOverlay: true,
              //       searchStyle: TextStyle(
              //         fontSize: 16,
              //         color: Colors.black.withOpacity(0.8),
              //       ),
              //       validator: (x) {
              //         if (!controller.listNameChapter.contains(x) ||
              //             x!.isEmpty) {
              //           return 'Please Enter a valid State';
              //         }
              //         return null;
              //       },
              //       searchInputDecoration: InputDecoration(
              //         focusedBorder: const OutlineInputBorder(
              //           borderSide: BorderSide(
              //             color: Colors.white,
              //           ),
              //         ),
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(16),
              //           borderSide: const BorderSide(color: Colors.white),
              //         ),
              //       ),
              //       maxSuggestionsInViewPort: 10,
              //       itemHeight: 24,
              //       // onTap: (x) {},
              //     ))),
              // const SizedBox(
              //   height: 16,
              // ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Obx(() {
                    return ListView.separated(
                      itemCount: controller.listChapter.length,
                      itemBuilder: (context, index) {
                        if (controller.listChapter.length - 1 == index &&
                            controller.loadMore.value) {
                          controller.loadMoreChapter();
                          return const Center(
                            child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator()),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                  "/reading/${controller.listChapter[index].id}",
                                  parameters: {
                                    'title':
                                        controller.listChapter[index].name ??
                                            "",
                                    'bookId': controller.bookId.value,
                                    'lastChap':
                                        controller.listChapter.length.toString()
                                  });
                            },
                            child: ItemChapter(
                              nameChapter:
                                  controller.listChapter[index].name ?? "",
                              index: index,
                            ),
                          );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemChapter extends StatelessWidget {
  const ItemChapter({
    Key? key,
    required this.nameChapter,
    required this.index,
  }) : super(key: key);

  final int index;
  final String nameChapter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Chương ${index + 1} : ',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black)),
              Expanded(
                child: Text(nameChapter,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
