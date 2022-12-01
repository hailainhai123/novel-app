
import 'package:json_annotation/json_annotation.dart';

part 'categories_grid_novel_model.g.dart';
@JsonSerializable()
class CategoriesGridNovelModel {
  @JsonKey(name: '_id')
  String? id;
  String? slugId;
  String? name;
  String? description;

  CategoriesGridNovelModel(this.id, this.slugId, this.name, this.description);

  factory CategoriesGridNovelModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesGridNovelModelFromJson(json);

}