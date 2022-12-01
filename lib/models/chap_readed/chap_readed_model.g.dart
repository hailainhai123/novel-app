// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chap_readed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterReadModel _$ChapterReadModelFromJson(Map<String, dynamic> json) =>
    ChapterReadModel(
      idNovel: json['idNovel'] as String,
      listChapterRead: (json['listChapterRead'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$ChapterReadModelToJson(ChapterReadModel instance) =>
    <String, dynamic>{
      'idNovel': instance.idNovel,
      'listChapterRead': instance.listChapterRead,
    };
