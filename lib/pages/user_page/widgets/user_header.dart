import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:novel_app_client/pages/user_page/user_controller.dart';
import 'package:novel_app_client/stl_widgets/image_network.dart';

import '../../../constant/api_url.dart';
import '../../../constant/icons_path.dart';
import '../../../constant/theme.dart';

class UserHeader extends GetView<UserController> {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: 120,
          padding: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(IconsPath.bgUserImage), fit: BoxFit.fitWidth),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: controller.isEdit.value
                        ? Stack(
                            children: [
                              InkWell(
                                onTap: () async {
                                  controller.onImageButtonPressed(
                                      context: context, ImageSource.gallery);
                                },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: controller.imagePick.value.path != ""
                                        ? Image.file(controller.imagePick.value)
                                        : NetWorkImageApp(
                                            urlImage: controller.userInformation
                                                    .value.avatarUrl ??
                                                ApiURL.emptyImage)),
                              ),
                              InkWell(
                                onTap: () async {
                                  controller.onImageButtonPressed(
                                      context: context, ImageSource.gallery);
                                },
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: double.maxFinite,
                                        color: Colors.grey.withOpacity(0.5),
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: NetWorkImageApp(
                                urlImage: controller
                                        .userInformation.value.avatarUrl ??
                                    ApiURL.emptyImage)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.isEdit.value
                          ? SizedBox(
                              width: 160,
                              height: 40,
                              child: TextField(
                                controller: controller.textEditingController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(0.0),
                                ),
                              ),
                            )
                          : Text(
                              controller.userInformation.value.displayName ??
                                  'Khách',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                      Text(controller.userInformation.value.email ?? '',
                          style: const TextStyle(
                              color: kGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // const Text('Số coin hiện có:  '),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 4.0),
                          //   child: Text('0'),
                          // ),
                          // SizedBox(
                          //   height: 24,
                          //   width: 24,
                          //   child: SvgPicture.asset(IconsPath.coinImage),
                          // ),
                        ],
                      )
                    ],
                  )),
                  GestureDetector(
                    onTap: () {
                      // Get.toNamed(kEditPage);

                      if (controller.isEdit.value) {
                        EasyLoading.show();
                        controller.updateUserName();
                      } else {
                        controller.isEdit.value = !controller.isEdit.value;
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(controller.isEdit.value ? Icons.save : Icons.edit,
                            color: kPrimaryColor),
                        Text(controller.isEdit.value ? "  Lưu" : '  Sửa',
                            style: const TextStyle(color: kPrimaryColor))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
