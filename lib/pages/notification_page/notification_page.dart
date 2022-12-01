import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/constant/theme.dart';

import '../../stl_widgets/loading_widget.dart';
import 'notification_controller.dart';

class NotificationsPage extends GetView<NotificationController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getNotifications();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo của tôi'),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_outlined, color: Colors.black),
        ),
      ),
      body: controller.obx(
          (state) => SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(24),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state!.length,
                              itemBuilder: (context, index) => IntrinsicHeight(
                                    child: Container(
                                      // height: 120,
                                      padding: const EdgeInsets.all(16),
                                      margin: const EdgeInsets.only(bottom: 16),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: kPrimaryColor),
                                                  width: 50,
                                                  height: 50,
                                                  child: const Icon(
                                                    Icons.notifications,
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("${state[index].title}",
                                                  style: const TextStyle(
                                                      fontSize: 18)),
                                              Text(
                                                  DateTime.parse(state[index]
                                                          .createdAt!)
                                                      .toLocal()
                                                      .toIso8601String()
                                                      .replaceAll('T', ' '),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: kGreyColor)),
                                              const SizedBox(height: 8),
                                              ContentNotification(
                                                  content:
                                                      state[index].content ??
                                                          "",
                                                  showContent:
                                                      state[index].showContent),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  ))),
                    )
                  ],
                ),
              ),
          onLoading: const LoadingWidget(
            message: "Đang tải thông báo",
          ),
          onEmpty: const Text('Không có dữ liệu'),
          onError: (error) => Center(child: Text("Đã có lỗi xảy ra $error"))),
    );
  }
}

class ContentNotification extends StatefulWidget {
  const ContentNotification({
    Key? key,
    required this.showContent,
    required this.content,
  }) : super(key: key);
  final bool showContent;
  final String content;

  @override
  State<ContentNotification> createState() => _ContentNotificationState();
}

class _ContentNotificationState extends State<ContentNotification> {
  late bool showContent;

  @override
  void initState() {
    super.initState();
    setState(() {
      showContent = widget.showContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showContent = !showContent;
        });
      },
      child: Text(
        widget.content,
        overflow: TextOverflow.ellipsis,
        maxLines: showContent ? 10 : 1,
      ),
    );
  }
}
