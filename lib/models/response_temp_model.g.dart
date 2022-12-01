// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_temp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseTempModel _$ResponseTempModelFromJson(Map<String, dynamic> json) =>
    ResponseTempModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ResponseTempModelToJson(ResponseTempModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
    };
