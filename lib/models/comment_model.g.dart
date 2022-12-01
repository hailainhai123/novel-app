// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['_id'] as String?,
      bookId: json['bookId'] as String?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      user: json['user'] == null
          ? null
          : UserInformation.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'bookId': instance.bookId,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'user': instance.user,
    };
