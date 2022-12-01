// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_novel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesNovelModel _$CategoriesNovelModelFromJson(
        Map<String, dynamic> json) =>
    CategoriesNovelModel(
      json['_id'] as String?,
      json['slugId'] as String?,
      json['name'] as String?,
      json['description'] as String?,
    );

Map<String, dynamic> _$CategoriesNovelModelToJson(
        CategoriesNovelModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'slugId': instance.slugId,
      'name': instance.name,
      'description': instance.description,
    };
