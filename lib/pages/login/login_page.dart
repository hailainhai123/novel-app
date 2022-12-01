import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/constant/icons_path.dart';
import 'package:novel_app_client/constant/theme.dart';
import 'package:novel_app_client/pages/login/login_controller.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            width: Get.width,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: SizedBox(
                                    width: Get.width / 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(32),
                                      child: Image.asset(
                                          'assets/images/truyen3k-app-icon.png'),
                                    ),
                                  )),
                              SizedBox(
                                width: 250,
                                height: 50,
                                child: SignInButton(
                                  Buttons.googleDark,
                                  text: "Đăng nhập với Google",
                                  padding: const EdgeInsets.all(15),
                                  onPressed: () async {
                                    controller.signInWithGoogle();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: 250,
                                height: 50,
                                child: SignInButton(
                                  Buttons.facebookNew,
                                  text: "Đăng nhập với Facebook",
                                  padding: const EdgeInsets.all(15),
                                  onPressed: () {
                                    controller.signInWithFacebook();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              GetPlatform.isIOS
                                  ? SizedBox(
                                      width: 250,
                                      height: 50,
                                      child: SignInButton(
                                        Buttons.apple,
                                        text: "Đăng nhập với Apple",
                                        padding: const EdgeInsets.all(15),
                                        onPressed: () {
                                          controller.signInWithApple();
                                        },
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        controller.skipLogin();
                                      },
                                      child: Row(
                                        children: const [
                                          Text('Đóng'),
                                          Icon(Icons.close)
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
