import 'package:json_annotation/json_annotation.dart';

part 'app_setting_model.g.dart';

@JsonSerializable()
class AppSettingModel {
  final num? fontSize;
  final String? textColor;

  AppSettingModel({this.fontSize, this.textColor});

  factory AppSettingModel.fromJson(Map<String, dynamic> json) =>
      _$AppSettingModelFromJson(json);
}
