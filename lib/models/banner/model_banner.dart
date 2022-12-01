import 'package:json_annotation/json_annotation.dart';
import 'package:novel_app_client/models/banner/banner_image_model.dart';

part 'model_banner.g.dart';

@JsonSerializable()
class BannerModel {
  @JsonKey(name: '_id')
  final String? id;
  final List<BannerImageModel>? image;
  final String? tittle;
  final String? linkTo;
  final int? order;

  BannerModel({this.id, this.image, this.tittle, this.linkTo, this.order});

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}
