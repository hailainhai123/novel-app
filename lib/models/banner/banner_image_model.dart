import 'package:json_annotation/json_annotation.dart';

part 'banner_image_model.g.dart';


@JsonSerializable()
class BannerImageModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? url;
  final String? name;

  BannerImageModel({this.id, this.url, this.name});

  factory BannerImageModel.fromJson(Map<String, dynamic> json) =>
      _$BannerImageModelFromJson(json);
}