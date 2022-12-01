
import 'package:json_annotation/json_annotation.dart';
import 'package:novel_app_client/models/grid_novel/categories_grid_novel_model.dart';
import 'package:novel_app_client/models/grid_novel/cover_grid_novel_model.dart';
import 'package:novel_app_client/models/grid_novel/rate_grid_novel_model.dart';

part 'grid_novel_model.g.dart';

@JsonSerializable()
class GridNovelModel {
  @JsonKey(name: '_id')
  String? id;
  String? slugId;
  String? name;
  List<CoverGridNovelModel>? cover;
  String? description;
  String? createdAt;
  String? updatedAt;
  bool? published;
  String? status;
  List<CategoriesGridNovelModel>? categories;
  List<String>? tags;
  int? lastChapter;
  int? totalViews;
  RateGridNovelModel? rate;

  GridNovelModel({
    this.id,
    this.slugId,
    this.name,
    this.cover,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.published,
    this.status,
    this.categories,
    this.tags,
    this.lastChapter,
    this.totalViews,
    this.rate});

  factory GridNovelModel.fromJson(Map<String, dynamic> json) =>
      _$GridNovelModelFromJson(json);

}