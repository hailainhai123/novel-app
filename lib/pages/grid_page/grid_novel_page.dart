import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/theme.dart';
import 'grid_pages_controller.dart';

class GridNovelPage extends StatefulWidget {
  const GridNovelPage({super.key});

  @override
  State<GridNovelPage> createState() => _GridNovelPageState();
}

class _GridNovelPageState extends State<GridNovelPage> {
  final GridPagesController controller = Get.put(GridPagesController());

  @override
  void initState() {
    controller.url.value = Get.parameters['url'] ?? '';
    controller.title.value = Get.parameters['title'] ?? "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<GridPagesController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
              Get.delete<GridPagesController>();
            },
            child: const Icon(Icons.keyboard_backspace_outlined,
                color: Colors.black)),
        // you can put Icon as well, it accepts any widget.
        backgroundColor: Colors.white,
        title: Obx(() => Text(controller.title.value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black))),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(top: 0, right: 16, left: 16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 16,
              childAspectRatio: 3 / 4.7456,
            ),
            itemCount: controller.gridNovel.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              if (index == controller.gridNovel.length - 1 &&
                  controller.loadMore.value) {
                controller.loadMoreNovel();
                return const Center(
                  child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator()),
                );
              }

              return InkWell(
                onTap: () {
                  Get.toNamed(
                      "/book_details/${controller.gridNovel[index].id}");
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                            imageUrl:
                                controller.gridNovel[index].cover![0].url ?? "",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.gridNovel[index].name ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14)),
                        const SizedBox(width: 4),
                        Text(
                            '${controller.gridNovel[index].totalViews} lượt xem',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: kGreyColor)),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
