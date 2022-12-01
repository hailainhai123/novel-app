// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grid_novel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GridNovelModel _$GridNovelModelFromJson(Map<String, dynamic> json) =>
    GridNovelModel(
      id: json['_id'] as String?,
      slugId: json['slugId'] as String?,
      name: json['name'] as String?,
      cover: (json['cover'] as List<dynamic>?)
          ?.map((e) => CoverGridNovelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      published: json['published'] as bool?,
      status: json['status'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) =>
              CategoriesGridNovelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      lastChapter: json['lastChapter'] as int?,
      totalViews: json['totalViews'] as int?,
      rate: json['rate'] == null
          ? null
          : RateGridNovelModel.fromJson(json['rate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GridNovelModelToJson(GridNovelModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'slugId': instance.slugId,
      'name': instance.name,
      'cover': instance.cover,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'published': instance.published,
      'status': instance.status,
      'categories': instance.categories,
      'tags': instance.tags,
      'lastChapter': instance.lastChapter,
      'totalViews': instance.totalViews,
      'rate': instance.rate,
    };
