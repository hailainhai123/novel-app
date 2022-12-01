// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      id: json['_id'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => BannerImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tittle: json['tittle'] as String?,
      linkTo: json['linkTo'] as String?,
      order: json['order'] as int?,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'tittle': instance.tittle,
      'linkTo': instance.linkTo,
      'order': instance.order,
    };
