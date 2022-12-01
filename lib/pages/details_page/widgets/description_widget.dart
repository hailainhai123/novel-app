import 'package:flutter/material.dart';
import 'package:novel_app_client/constant/theme.dart';

class DescriptionWidget extends StatelessWidget {
  final String title;
  final String description;
  final Widget? child;
  final bool? showAll;
  final Function? show;

  const DescriptionWidget(
      {super.key,
      required this.title,
      required this.description,
      this.show,
      this.child,
      this.showAll = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                showAll ?? false
                    ? InkWell(
                        onTap: () {
                          show!();
                        },
                        child: const Text('Xem tất cả',
                            style:
                                TextStyle(fontSize: 12, color: kPrimaryColor)),
                      )
                    : const SizedBox()
              ],
            ),
          ),
          child ??
              Text(description,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: kGreyColor,
                      fontSize: 14))
        ],
      ),
    );
  }
}
