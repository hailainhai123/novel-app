// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NovelResponseModel _$NovelResponseModelFromJson(Map<String, dynamic> json) =>
    NovelResponseModel(
      id: json['_id'] as String?,
      slugId: json['slugId'] as String?,
      name: json['name'] as String?,
      cover: (json['cover'] as List<dynamic>?)
          ?.map((e) => CoverNovelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      published: json['published'] as bool?,
      status: json['status'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoriesNovelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      shortDescription: json['shortDescription'] as String?,
      lastChapter: json['lastChapter'] as int?,
      totalViews: json['totalViews'] as int?,
      rate: json['rate'] == null
          ? null
          : RateModel.fromJson(json['rate'] as Map<String, dynamic>),
      searches: json['searches'] as int?,
    );

Map<String, dynamic> _$NovelResponseModelToJson(NovelResponseModel instance) =>
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
      'shortDescription': instance.shortDescription,
      'searches': instance.searches,
    };
