import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:measure_size/measure_size.dart';
import 'package:novel_app_client/chapter.dart';

class VerticalReadTypeWidget extends StatefulWidget {
  const VerticalReadTypeWidget({Key? key}) : super(key: key);

  @override
  State<VerticalReadTypeWidget> createState() => _VerticalReadTypeWidgetState();
}

class _VerticalReadTypeWidgetState extends State<VerticalReadTypeWidget> {
   Size _size = Size.infinite;
  double sizeText = 14;
  double progress = 0.5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MeasureSize(
      onChange: (newSize) => setState(() => _size = newSize),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(getSplittedText(_size , TextStyle(fontSize: sizeText), contentChap)[0],style: TextStyle(fontSize: sizeText)),
      ),
    );
  }

  List<String> getSplittedText(
      Size pageSize, TextStyle textStyle, String text) {
    print('dzo day ${pageSize.width} ${pageSize.height}');
    final List<String> _pageTexts = [];
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: pageSize.width,
    );

    List<LineMetrics> lines = textPainter.computeLineMetrics();
    print(lines.length);
    double currentPageBottom = pageSize.height;
    int currentPageStartIndex = 0;
    int currentPageEndIndex = 0;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final left = line.left;
      final top = line.baseline - line.ascent;
      final bottom = line.baseline + line.descent;


      // Current line overflow page
      if (currentPageBottom < bottom) {
        currentPageEndIndex =
            textPainter.getPositionForOffset(Offset(left, top)).offset;
        final pageText =
            text.substring(currentPageStartIndex, currentPageEndIndex);
        _pageTexts.add(pageText);

        currentPageStartIndex = currentPageEndIndex;
        currentPageBottom = top + pageSize.height;
      }
    }

    showHeight(text);
    showHeight(_pageTexts[0]);
    print(_pageTexts.length);
    return _pageTexts;
  }

  void showHeight(String text){
    final span=TextSpan(text:text);
    final tp =TextPainter(text:span,textDirection: TextDirection.ltr);
    tp.layout(maxWidth: MediaQuery.of(context).size.width); // equals the parent screen width
    print(tp.height);
  }
}
