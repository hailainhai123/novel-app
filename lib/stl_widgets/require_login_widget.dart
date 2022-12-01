import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/constant/routes.dart';

import '../constant/icons_path.dart';
import '../constant/theme.dart';

class RequireLoginWidget extends StatelessWidget {
  const RequireLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: Get.width,
                child: AspectRatio(
                    aspectRatio: 359 / 286,
                    child: SvgPicture.asset(
                      IconsPath.imageBackground,
                      color: kPrimaryColor,
                    ))),
            const SizedBox(height: 300)
          ],
        ),
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: Get.width / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Image.asset('assets/images/truyen3k-app-icon.png'),
                    ),
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 48),
                child: Text(
                  'Vui lòng đăng nhập để sử dụng hết tiện ích của Truyện 3K.',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: Get.width - 64,
                height: 48,
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(kLoginPage,
                          arguments: {"showBackIcon": true});
                    },
                    child: Text(
                      'Đăng nhập'.toUpperCase(),
                      style: const TextStyle(fontSize: 18),
                    )),
              ),
              const SizedBox(width: 16)
            ],
          ),
        ),
      ],
    );
  }
}
