// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      firebaseId: json['firebaseId'] as String,
      username: json['username'] as String,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      firebaseAvatarUrl: json['firebaseAvatarUrl'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'firebaseId': instance.firebaseId,
      'username': instance.username,
      'email': instance.email,
      'avatar': instance.avatar,
      'firebaseAvatarUrl': instance.firebaseAvatarUrl,
    };
