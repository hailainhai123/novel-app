import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/utils/global_controller.dart';

import '../../../constant/theme.dart';

class SettingPage extends GetView<GlobalController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getSetting();

    return Scaffold(
      appBar: AppBar(
          title: const Text("Cài đặt"),
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.keyboard_backspace_outlined,
                  color: Colors.black))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Obx(() => Column(
                    children: [
                      _chooseSizeText(),
                      const SizedBox(height: 16),
                      _chooseColor(),
                      const SizedBox(height: 16),
                    ],
                  )),
              Obx(() => Container(
                    decoration: BoxDecoration(
                        color: controller.colorChoose.value == kPrimaryColor
                            ? Colors.white
                            : controller.colorChoose.value == Colors.white
                                ? Colors.black
                                : Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text('Văn bản chính sẽ trông như thế này',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: controller.fontSize.value,
                                color: controller.colorChoose.value)),
                      ),
                    ),
                  )),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    controller.saveSetting();
                  },
                  child: const Text('Lưu cài đặt'))
            ]),
      ),
    );
  }

  Widget _chooseColor() {
    return SizedBox(
      height: 40,
      child: Row(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Icon(
                  Icons.format_color_text,
                  size: 16,
                  color: kPrimaryColor,
                ),
                SizedBox(width: 4),
                Text('Màu chữ :', style: TextStyle(color: Colors.black)),
              ],
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: controller.textColors
                .map((element) => InkWell(
                      onTap: () {
                        controller.colorChoose.value = element;
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: element,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: controller.colorChoose.value == element
                                    ? kPrimaryColor
                                    : Colors.black)),
                      ),
                    ))
                .toList(),
          ),
        )
      ]),
    );
  }

  Widget _chooseSizeText() {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Column(
            children: [
              Expanded(child: Container()),
              Row(
                children: [
                  Icon(
                    Icons.format_size,
                    size: 16,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: 4),
                  const Text('Cỡ chữ :', style: TextStyle(color: Colors.black)),
                ],
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: controller.fontSizeText
                  .map((element) => InkWell(
                        onTap: () {
                          controller.fontSize.value = element;
                        },
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Column(
                            children: [
                              Expanded(child: Container()),
                              Text('aA',
                                  style: TextStyle(
                                      fontSize: element,
                                      color:
                                          controller.fontSize.value == element
                                              ? kPrimaryColor
                                              : Colors.black)),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
