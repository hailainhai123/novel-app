import 'package:json_annotation/json_annotation.dart';

part 'settings.model.g.dart';

@JsonSerializable()
class SettingsModel {
  final String writerPolicy;

  SettingsModel({
    required this.writerPolicy,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}
