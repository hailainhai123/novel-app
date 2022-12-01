import 'package:json_annotation/json_annotation.dart';
import 'package:novel_app_client/models/user_infomation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  @JsonKey(name: '_id')
  String? id;
  String? bookId;
  String? content;
  String? createdAt;
  UserInformation? user;

  CommentModel({this.id, this.bookId, this.content, this.createdAt, this.user});

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
