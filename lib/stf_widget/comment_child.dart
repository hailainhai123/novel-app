import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app_client/constant/api_url.dart';
import 'package:novel_app_client/constant/icons_path.dart';
import 'package:novel_app_client/models/comment_model.dart';
import 'package:novel_app_client/utils/global_controller.dart';

class CommentChild extends StatefulWidget {
  final CommentModel comment;

  const CommentChild({super.key, required this.comment});

  @override
  State<CommentChild> createState() => _CommentChildState();
}

class _CommentChildState extends State<CommentChild> {
  final GlobalController globalController = Get.find();
  bool voted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(
                    widget.comment.user?.avatarUrl ?? ApiURL.emptyImage),
                backgroundImage: NetworkImage(ApiURL.emptyImage),
              ),
              const SizedBox(width: 8),
              Text(widget.comment.user?.displayName ?? ""),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(widget.comment.createdAt?.split("T")[0] ?? "",
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(widget.comment.content ?? "",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ))),
          // Row(
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         if (globalController.userLogin.value) {
          //           setState(() {
          //             voted = !voted;
          //           });
          //         } else {
          //           Get.showSnackbar(const GetSnackBar(
          //               titleText: Text(
          //                   "Vui lòng đăng nhập để sử dụng tính năng này")));
          //         }
          //       },
          //       child: Icon(
          //           voted ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
          //           size: 24,
          //           color: Colors.black.withAlpha(124)),
          //     ),
          //     const SizedBox(width: 8),
          //     const Text('Số lượng vote')
          //   ],
          // )
        ],
      ),
    );
  }
}
