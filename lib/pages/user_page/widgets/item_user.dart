import 'package:flutter/material.dart';
import 'package:novel_app_client/constant/theme.dart';

class ItemUserPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? rightValue;
  final Function? onTap;

  const ItemUserPage(
      {super.key,
      required this.icon,
      required this.title,
      this.rightValue,
      this.onTap});

  // const ItemUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          onTap == null ? null : onTap!();
        },
        child: Container(
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: kGreyColor, width: 0.5))),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
          child: Row(
            children: [
              Icon(icon, color: kPrimaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14)),
              ),
              Row(
                children: [
                  Text(rightValue ?? "",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kGreyColor)),
                  const SizedBox(
                      width: 24,
                      height: 24,
                      child:
                          Icon(Icons.keyboard_arrow_right, color: Colors.grey))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
