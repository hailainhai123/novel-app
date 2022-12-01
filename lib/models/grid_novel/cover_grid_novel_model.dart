
import 'package:json_annotation/json_annotation.dart';

part 'cover_grid_novel_model.g.dart';

@JsonSerializable()
class CoverGridNovelModel {
  final String? url;
  final String? name;

  CoverGridNovelModel(this.url, this.name);

  factory CoverGridNovelModel.fromJson(Map<String, dynamic> json) =>
      _$CoverGridNovelModelFromJson(json);
}