import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:novel_app_client/arbe_module/api/api_dio_controller.dart';
import 'package:novel_app_client/models/user_infomation.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class UserController extends GetxController {
  var imagePick = File("").obs;
  dynamic _pickImageError;
  var isUpdating = false.obs;
  String? _retrieveDataError;
  final ImagePicker picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  var userInformation = UserInformation().obs;
  final TextEditingController textEditingController = TextEditingController();
  var isEdit = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void getUserInformation() async {
    var data = await ApiDioController.getUserInformation();
    userInformation.value = data ?? UserInformation();
    if (data != null) {
      textEditingController.text = data.displayName!;
    }
    isEdit.value = false;
    EasyLoading.dismiss();
    isUpdating.value = false;
  }

  Future<void> onImageButtonPressed(ImageSource source,
      {required BuildContext context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      try {
        final List<XFile>? pickedFileList = await picker.pickMultiImage(
          maxWidth: 1000,
          maxHeight: 1000,
          imageQuality: 100,
        );
        imagePick.value = File(pickedFileList![0].path);
      } catch (e) {
        _pickImageError = e;
      }
    } else {
      try {
        final XFile? pickedFile = await picker.pickImage(
          source: source,
          maxWidth: 1000,
          maxHeight: 1000,
          imageQuality: 100,
        );

        _setImageFileListFromFile(pickedFile);
      } catch (e) {
        _pickImageError = e;
      }
    }
  }

  void updateUserName() async {
    // await
    isUpdating.value = true;
    await ApiDioController.updateUserName(textEditingController.text)
        .then((value) => {getUserInformation()});
  }

  void _setImageFileListFromFile(XFile? value) async {
    if (value == null) return;
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: value.path,
      cropStyle: CropStyle.circle,
      compressQuality: 100,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile == null) return;
    imagePick.value = File(croppedFile.path);
    await ApiDioController.updateAvatar(imagePick.value);
  }
}
