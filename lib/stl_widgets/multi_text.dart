import 'package:flutter/cupertino.dart';

import '../constant/theme.dart';

class MultiText extends StatelessWidget {
  final String firstText;
  final List<TextSpan> child;

  const MultiText({super.key, required this.firstText, required this.child});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: const TextStyle(
            color: kGreyColor, fontSize: 14, fontWeight: FontWeight.w600),
        children: child,
      ),
    );
  }
}
