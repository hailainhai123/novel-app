import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/pages/user_page/edit_profile/edit_profile_controller.dart';

class EditProfilePage extends GetView<EditProfileController> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa thông tin người dùng'),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_outlined, color: Colors.black),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 80, height: 80, child: CircleAvatar()),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(),
                        TextFormField(),
                        TextFormField(),
                        TextFormField(),
                        TextFormField(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: 240,
                  height: 40,
                  child: ElevatedButton(onPressed: () {}, child: Text('Lưu')))
            ],
          ),
        ),
      ),
    );
  }
}
