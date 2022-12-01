import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:novel_app_client/arbe_module/authen/authen_helper.dart';
import 'package:novel_app_client/constant/icons_path.dart';
import 'package:novel_app_client/constant/routes.dart';
import 'package:sign_in_button/sign_in_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              height: Get.height,
              child: Column(children: [
                Stack(
                  children: [
                    Image.asset(IconsPath.appbarHomeImage),
                    Positioned(
                        top: 48,
                        right: 24,
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.close)))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Số điện thoại',
                        ),
                      ),
                      const SizedBox(height: 16),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mật khẩu',
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ))),
                            child: const Text('Đăng kí',
                                style: TextStyle(fontSize: 18)),
                          )),
                      const SizedBox(height: 16),
                      const SizedBox(
                        width: double.infinity,
                        child: Center(child: Text('hoặc')),
                      ),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: SignInButton(
                          Buttons.google,
                          text: "Đăng nhập với Google",
                          padding: const EdgeInsets.all(15),
                          onPressed: () async {
                            _googleSignIn.disconnect();
                            AuthenticationHelper.instance.handleGoogleSignIn(
                              (success) => {
                                Get.showSnackbar(const GetSnackBar(
                                        message: "Đăng nhập thành công"))
                                    .show()
                                    .then((value) =>
                                        {Get.offAndToNamed(kRouteIndex)})
                              },
                              (errorMessage) => {
                                print("Flutter lỗi =======> $errorMessage"),
                              },
                            );
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
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: SignInButton(
                          Buttons.apple,
                          text: "Đăng nhập với AppleId",
                          padding: const EdgeInsets.all(15),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    ));
  }
}
