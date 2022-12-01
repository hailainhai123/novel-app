import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;

  const LoadingWidget({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
              const SizedBox(height: 16),
              Text(message ?? 'Đang tải thông tin truyện')
            ],
          ),
        ),
      ],
    );
  }
}
