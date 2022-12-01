
import 'package:json_annotation/json_annotation.dart';

part 'categories_novel_model.g.dart';

@JsonSerializable()
class CategoriesNovelModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? slugId;
  final String? name;
  final String? description;

  CategoriesNovelModel(this.id, this.slugId, this.name, this.description);

  factory CategoriesNovelModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesNovelModelFromJson(json);
}