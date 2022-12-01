// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingStateModel _$ReadingStateModelFromJson(Map<String, dynamic> json) =>
    ReadingStateModel(
      id: json['_id'] as String?,
      bookId: json['bookId'] as String? ?? "",
      userId: json['userId'] as String?,
      currentChapter: json['currentChapter'] as int?,
      followed: json['followed'] as bool?,
      lastReadAt: json['lastReadAt'] as String?,
      rate: json['rate'],
    );

Map<String, dynamic> _$ReadingStateModelToJson(ReadingStateModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'bookId': instance.bookId,
      'userId': instance.userId,
      'currentChapter': instance.currentChapter,
      'followed': instance.followed,
      'lastReadAt': instance.lastReadAt,
      'rate': instance.rate,
    };
