// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_chap_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListChapModel _$ListChapModelFromJson(Map<String, dynamic> json) =>
    ListChapModel(
      id: json['_id'] as String?,
      number: json['number'] as int?,
      bookId: json['bookId'] as String?,
      name: json['name'] as String?,
      createdAt: json['createdAt'] as String?,
      price: json['price'] as int?,
      totalComments: json['totalComments'] as int?,
      totalUnlocked: json['totalUnlocked'] as int?,
    );

Map<String, dynamic> _$ListChapModelToJson(ListChapModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'number': instance.number,
      'bookId': instance.bookId,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'price': instance.price,
      'totalComments': instance.totalComments,
      'totalUnlocked': instance.totalUnlocked,
    };
