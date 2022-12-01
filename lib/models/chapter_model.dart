import 'package:json_annotation/json_annotation.dart';

part 'chapter_model.g.dart';

@JsonSerializable()
class ChapterModel {
  @JsonKey(name: '_id')
  String? id;
  int? number;
  String? bookId;
  String? name;
  String? content;
  String? createdAt;
  int? price;

  ChapterModel(
      {this.id,
      this.number,
      this.bookId,
      this.name,
      this.content,
      this.createdAt,
      this.price});

  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);
}
