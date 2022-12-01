import 'package:json_annotation/json_annotation.dart';

part 'response_temp_model.g.dart';

@JsonSerializable()
class ResponseTempModel {
  final int statusCode;
  final String? message;

  ResponseTempModel({required this.statusCode, required this.message});

  factory ResponseTempModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseTempModelFromJson(json);
}
