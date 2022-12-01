import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'browse_categories_model.g.dart';

@JsonSerializable()
class BrowseCategoriesModel {
  @JsonKey(name: '_id')
  final String id;
  final int order;
  final String name;
  final String desc;
  final String imageCover;

  BrowseCategoriesModel({
    required this.id,
    required this.order,
    required this.name,
    required this.desc,
    required this.imageCover
});

 factory BrowseCategoriesModel.fromJson(Map<String, dynamic> json) => _$BrowseCategoriesModelFromJson(json);
}



@JsonSerializable()
class BrowseCategoriesModelData{
  final bool success;
  final List<BrowseCategoriesModel> data;

  BrowseCategoriesModelData({
    required this.success,
    required this.data
});

  factory BrowseCategoriesModelData.fromJson(Map<String, dynamic> json) => _$BrowseCategoriesModelDataFromJson(json);
}