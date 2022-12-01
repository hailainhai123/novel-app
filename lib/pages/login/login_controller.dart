import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/navigation/main_page.dart';
import 'package:novel_app_client/pages/home/home_controller.dart';
import 'package:novel_app_client/utils/global_controller.dart';

import '../../arbe_module/api/api_dio_controller.dart';
import '../../arbe_module/authen/authen_helper.dart';
import '../../constant/routes.dart';

class LoginController extends GetxController {
  final GlobalController globalController = Get.find();
  var loading = false.obs;

  void setLoading() => loading.value = !loading.value;

  void signInWithGoogle() async {
    loading.value = true;
    AuthenticationHelper.instance.handleGoogleSignIn(
      (success) async {
        loading.value = false;
        globalController.userLogin.value = true;
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) return;
        String token = await user.getIdToken();
        ApiDioController.getAndSaveToken(token).then((value) async {
          return await _success();
        });
      },
      (errorMessage) => {
        loading.value = false,
        print("Flutter lỗi =======> $errorMessage"),
      },
    );
  }

  void signInWithApple() async {
    loading.value = true;
    AuthenticationHelper.instance.signInWithApple((success) async {
      loading.value = false;
      globalController.userLogin.value = true;
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      String token = await user.getIdToken();
      ApiDioController.getAndSaveToken(token).then((value) async {
        return await _success();
      });
    });
  }

  void signInWithFacebook() async {
    loading.value = true;
    AuthenticationHelper.instance.signInWithFacebook((success) async {
      loading.value = false;
      if (success == null) return;
      globalController.userLogin.value = true;
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      String token = await user.getIdToken();
      ApiDioController.getAndSaveToken(token).then((value) async {
        return await _success();
      });
    });
  }

  void skipLogin() async {
    Get.find<HomeController>().refreshController();
    Get.back();
  }

  Future _success() async {
    Get.find<HomeController>().refreshController();
    await Get.find<HomeController>().getLastReading();
    Get.back();
    Get.snackbar('Thông báo', 'Đăng nhập thành công',
        snackPosition: SnackPosition.TOP);
  }
}
