// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) => ChapterModel(
      id: json['_id'] as String?,
      number: json['number'] as int?,
      bookId: json['bookId'] as String?,
      name: json['name'] as String?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      price: json['price'] as int?,
    );

Map<String, dynamic> _$ChapterModelToJson(ChapterModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'number': instance.number,
      'bookId': instance.bookId,
      'name': instance.name,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'price': instance.price,
    };
