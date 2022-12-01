import 'package:json_annotation/json_annotation.dart';

part 'reading_state_model.g.dart';

@JsonSerializable()
class ReadingStateModel {
  @JsonKey(name: '_id')
  String? id;
  String? bookId;
  String? userId;
  int? currentChapter;
  bool? followed;
  String? lastReadAt;
  dynamic rate;

  ReadingStateModel(
      {this.id,
      this.bookId = "",
      this.userId,
      this.currentChapter,
      this.followed,
      this.lastReadAt,
      this.rate});

  factory ReadingStateModel.fromJson(Map<String, dynamic> json) =>
      _$ReadingStateModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingStateModelToJson(this);
}
