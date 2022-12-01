import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:novel_project/helper/request_helper.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  final String firebaseId;
  final String username;
  String? email;
  String? avatar;
  String? firebaseAvatarUrl;

  UserData({
    required this.firebaseId,
    required this.username,
    this.email,
    this.avatar,
    this.firebaseAvatarUrl,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

}
