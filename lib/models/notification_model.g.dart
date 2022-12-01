// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      showContent: json['showContent'] as bool? ?? false,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'title': instance.title,
      'content': instance.content,
      'link': instance.link,
      'showContent': instance.showContent,
    };
