import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:novel_app_client/constant/routes.dart';
import 'package:novel_app_client/pages/details_page/book_details_controller.dart';
import 'package:novel_app_client/stl_widgets/image_network.dart';
import 'package:novel_app_client/utils/global_controller.dart';

import '../../../constant/icons_path.dart';
import '../../../constant/theme.dart';
import '../../vote_dialog/vote_dialog_page.dart';

class BookInfoWidget extends GetWidget<BookDetailsController> {
  BookInfoWidget({Key? key}) : super(key: key);
  final globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 56),
            Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xfff6f6f6),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 1.2,
                        spreadRadius: 1,
                        offset: const Offset(0, 2))
                  ]),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 24),
              // height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Column(
                          children: const [
                            Icon(Icons.remove_red_eye_outlined,
                                color: kGreyColor),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          children: [
                            const Text('Đã đọc',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: kGreyColor)),
                            Text('${controller.state?.totalViews}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ],
                        )
                      ],
                    ),
                  ),
                  IntrinsicHeight(
                    child: InkWell(
                      onTap: () {
                        globalController.userLogin.value
                            ? showGeneralDialog(
                                barrierLabel: "Label",
                                barrierDismissible: true,
                                barrierColor: Colors.black.withOpacity(0.5),
                                transitionDuration:
                                    const Duration(milliseconds: 700),
                                context: context,
                                pageBuilder: (context, anim1, anim2) {
                                  return const VoteDialogPage();
                                },
                                transitionBuilder:
                                    (context, anim1, anim2, child) {
                                  return SlideTransition(
                                    position: Tween(
                                            begin: const Offset(0, 1),
                                            end: const Offset(0, 0))
                                        .animate(anim1),
                                    child: child,
                                  );
                                },
                              )
                            : controller.showDialogLogin(context);
                      },
                      child: Row(
                        children: [
                          Column(
                            children: const [
                              Icon(Icons.star_outline, color: kGreyColor),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Column(
                            children: [
                              const Text('Đánh giá',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: kGreyColor)),
                              Text('${controller.state?.rate?.avg!}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  IntrinsicHeight(
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          "/list_chap/${controller.id}",
                        );
                      },
                      child: Row(
                        children: [
                          Column(
                            children: const [
                              Icon(Icons.view_sidebar_outlined,
                                  color: kGreyColor),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Column(
                            children: [
                              const Text('Chương',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: kGreyColor)),
                              Text('${controller.state?.lastChapter}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                    width: 107,
                    height: 156,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: NetWorkImageApp(
                            urlImage: controller.state?.cover![0].url ?? ""))),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${controller.state?.name}',
                              maxLines: 2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16)),
                          // Text('J.D. Salinger',
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 18,
                          //         color: kGreyColor)),
                        ],
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget requireLoginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Đăng nhập để sử dụng tất cả chức năng ',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Đăng nhập')),
            const SizedBox(width: 16),
            ElevatedButton(onPressed: () {}, child: const Text('Đăng ký')),
          ],
        )
      ],
    );
  }
}
