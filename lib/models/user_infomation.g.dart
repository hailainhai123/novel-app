// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_infomation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInformation _$UserInformationFromJson(Map<String, dynamic> json) =>
    UserInformation(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      disabled: json['disabled'] as bool?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      tokensValidAfterTime: json['tokensValidAfterTime'] as String?,
      firebaseToken: json['firebaseToken'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      firebaseId: json['firebaseId'] as String?,
      lastOnlineAt: json['lastOnlineAt'] == null
          ? null
          : DateTime.parse(json['lastOnlineAt'] as String),
      providerData: (json['providerData'] as List<dynamic>?)
          ?.map((e) => ProviderData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserInformationToJson(UserInformation instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'disabled': instance.disabled,
      'metadata': instance.metadata,
      'tokensValidAfterTime': instance.tokensValidAfterTime,
      'providerData': instance.providerData,
      'firebaseToken': instance.firebaseToken,
      'lastOnlineAt': instance.lastOnlineAt?.toIso8601String(),
      'firebaseId': instance.firebaseId,
      'avatarUrl': instance.avatarUrl,
    };
