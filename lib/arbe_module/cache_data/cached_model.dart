

import 'package:meta/meta.dart';

class CachedModel {
  final String body;
  final DateTime expirtedTime;

  CachedModel({
    required this.body,
    required this.expirtedTime,
  });

  factory CachedModel.fromJson(Map<String, dynamic> json) {
    return CachedModel(
      body: json['body'],
      expirtedTime: DateTime.parse(json['expirtedTime']),
    );
  }

  Map<String, dynamic> toJson() => {
        'body': body,
        'expirtedTime': expirtedTime.toString(),
      };
}
