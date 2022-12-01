import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/arbe_module/utils/user_pref.dart';
import 'package:novel_app_client/constant/routes.dart';
import 'package:novel_app_client/constant/styles.dart';
import 'package:novel_app_client/constant/theme.dart';
import 'package:novel_app_client/models/user_infomation.dart';
import 'package:novel_app_client/pages/user_page/setting_page/setting_page.dart';
import 'package:novel_app_client/pages/user_page/user_controller.dart';
import 'package:novel_app_client/pages/user_page/widgets/item_user.dart';
import 'package:novel_app_client/pages/user_page/widgets/user_header.dart';
import 'package:novel_app_client/stl_widgets/require_login_widget.dart';
import 'package:novel_app_client/utils/global_controller.dart';

class UserPage extends GetView<UserController> {
  final globalController = Get.find<GlobalController>();

  UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (globalController.userLogin.value) {
        controller.getUserInformation();
      }
    });

    return SafeArea(child: Obx(() {
      if (!globalController.userLogin.value) {
        return const RequireLoginWidget();
      } else {
        return IgnorePointer(
          ignoring: controller.isUpdating.value,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const UserHeader(),
                  const SizedBox(height: 16),
                  // IntrinsicHeight(
                  //   child: Container(
                  //     // height: 200,
                  //     width: double.infinity,
                  //     padding: const EdgeInsets.all(16),
                  //     decoration: Styles.shadowDecoration,
                  //     child: Row(
                  //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Expanded(
                  //           flex: 1,
                  //           child: Column(
                  //             children: [
                  //               SizedBox(
                  //                   height: 40,
                  //                   width: 40,
                  //                   child: Image.asset(IconsPath.paymentIcon)),
                  //               const Text(
                  //                 'Thanh\n Toán',
                  //                 textAlign: TextAlign.center,
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //         Expanded(
                  //           flex: 1,
                  //           child: Column(
                  //             children: [
                  //               SizedBox(
                  //                   height: 40,
                  //                   width: 40,
                  //                   child: Image.asset(IconsPath.voucherIcon)),
                  //               const Text(
                  //                 'Voucher',
                  //                 // maxLines: 2,
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //         Expanded(
                  //           flex: 1,
                  //           child: Column(
                  //             children: [
                  //               SizedBox(
                  //                   height: 40,
                  //                   width: 40,
                  //                   child: Image.asset(IconsPath.promoteIcon)),
                  //               const Text(
                  //                 'Khuyến mãi',
                  //                 textAlign: TextAlign.center,
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //         Expanded(
                  //           flex: 1,
                  //           child: Column(
                  //             children: [
                  //               SizedBox(
                  //                   height: 40,
                  //                   width: 40,
                  //                   child: Image.asset(IconsPath.historyIcon)),
                  //               const Text('Lịch sử')
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 16),
                  Container(
                    decoration: Styles.shadowDecoration,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        // const ItemUserPage(
                        //     icon: Icons.language,
                        //     title: "Ngôn ngữ",
                        //     rightValue: "English"),
                        ItemUserPage(
                            onTap: () {
                              Get.toNamed(kNotificationPage);
                            },
                            icon: Icons.notifications_none_outlined,
                            title: "Thông báo"),
                        ItemUserPage(
                            onTap: () {
                              Get.to(() => SettingPage());
                            },
                            icon: Icons.settings,
                            title: "Cài đặt"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 24),
                          child: InkWell(
                            onTap: () {
                              _signOut('Đăng xuất thành công');
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.logout,
                                  color: kPrimaryColor,
                                ),
                                SizedBox(width: 8),
                                Text('Đăng xuất',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                width: 1, color: kPrimaryColor)),
                        onPressed: () {
                          Get.defaultDialog(
                              title: "Thông báo",
                              middleText:
                                  "Bạn có chắc chắn muốn vô hiệu hoá tài khoản của bạn không?",
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text('Bỏ qua',
                                        style: TextStyle(
                                            color: Colors.grey.shade500))),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                      _signOut('Vô hiệu hoá thành công');
                                    },
                                    child: const Text('Có')),
                              ]);
                        },
                        child: const Text('Vô hiệu hoá tài khoản')),
                  )
                ],
              ),
            ),
          ),
        );
      }
    }));
  }

  Future<void> _signOut(String message) async {
    await FirebaseAuth.instance.signOut().then((value) {
      Get.snackbar('Thông báo', message, snackPosition: SnackPosition.TOP);
      globalController.userLogin.value = false;
      UserPref().setUser(UserInformation());
    });
  }
}
