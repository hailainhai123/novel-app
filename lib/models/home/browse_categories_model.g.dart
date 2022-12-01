// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browse_categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrowseCategoriesModel _$BrowseCategoriesModelFromJson(
        Map<String, dynamic> json) =>
    BrowseCategoriesModel(
      id: json['_id'] as String,
      order: json['order'] as int,
      name: json['name'] as String,
      desc: json['desc'] as String,
      imageCover: json['imageCover'] as String,
    );

Map<String, dynamic> _$BrowseCategoriesModelToJson(
        BrowseCategoriesModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'order': instance.order,
      'name': instance.name,
      'desc': instance.desc,
      'imageCover': instance.imageCover,
    };

BrowseCategoriesModelData _$BrowseCategoriesModelDataFromJson(
        Map<String, dynamic> json) =>
    BrowseCategoriesModelData(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => BrowseCategoriesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrowseCategoriesModelDataToJson(
        BrowseCategoriesModelData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
