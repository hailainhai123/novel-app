import 'package:json_annotation/json_annotation.dart';

part 'user_infomation.g.dart';

@JsonSerializable()
class UserInformation {
  @JsonKey(name: '_id')
  String? id;
  String? email;
  bool? emailVerified;
  String? displayName;

  //TODO: Để tạm xoá sau
  String? photoURL;
  bool? disabled;
  Metadata? metadata;
  String? tokensValidAfterTime;
  List<ProviderData>? providerData;
  String? firebaseToken;
  DateTime? lastOnlineAt;
  String? firebaseId;
  String? avatarUrl;

  UserInformation(
      {this.id,
      this.email,
      this.emailVerified,
      this.displayName,
      this.photoURL,
      this.disabled,
      this.metadata,
      this.tokensValidAfterTime,
      this.firebaseToken,
      this.avatarUrl,
      this.firebaseId,
      this.lastOnlineAt,
      this.providerData});

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      _$UserInformationFromJson(json);
}

class Metadata {
  String? lastSignInTime;
  String? creationTime;

  Metadata({this.lastSignInTime, this.creationTime});

  Metadata.fromJson(Map<String, dynamic> json) {
    lastSignInTime = json['lastSignInTime'];
    creationTime = json['creationTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastSignInTime'] = lastSignInTime;
    data['creationTime'] = creationTime;
    return data;
  }
}

class ProviderData {
  String? uid;
  String? displayName;
  String? email;
  String? photoURL;
  String? providerId;

  ProviderData(
      {this.uid, this.displayName, this.email, this.photoURL, this.providerId});

  ProviderData.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    displayName = json['displayName'];
    email = json['email'];
    photoURL = json['photoURL'];
    providerId = json['providerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['displayName'] = displayName;
    data['email'] = email;
    data['photoURL'] = photoURL;
    data['providerId'] = providerId;
    return data;
  }
}
