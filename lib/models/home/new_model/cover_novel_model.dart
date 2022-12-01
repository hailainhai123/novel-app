
import 'package:json_annotation/json_annotation.dart';

part 'cover_novel_model.g.dart';

@JsonSerializable()
class CoverNovelModel {
  final String? url;
  final String? name;

  CoverNovelModel(this.url, this.name);

  factory CoverNovelModel.fromJson(Map<String, dynamic> json) =>
      _$CoverNovelModelFromJson(json);
}