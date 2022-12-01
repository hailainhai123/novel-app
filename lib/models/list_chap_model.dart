import 'package:json_annotation/json_annotation.dart';

part 'list_chap_model.g.dart';

@JsonSerializable()
class ListChapModel {
  @JsonKey(name: '_id')
  String? id;
  int? number;
  String? bookId;
  String? name;
  String? createdAt;
  int? price;
  int? totalComments;
  int? totalUnlocked;

  ListChapModel(
      {this.id,
        this.number,
        this.bookId,
        this.name,
        this.createdAt,
        this.price,
        this.totalComments,
        this.totalUnlocked});

  factory ListChapModel.fromJson(Map<String, dynamic> json) =>
      _$ListChapModelFromJson(json);
}