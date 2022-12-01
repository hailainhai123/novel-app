import 'package:json_annotation/json_annotation.dart';

part 'meta_model.g.dart';

@JsonSerializable()
class MetaModel {
  final int? page;
  final int? size;
  final int? totalPages;
  final bool? hasPrevPage;
  final bool? hasNextPage;
  final int? totalDocs;

  MetaModel(this.page, this.size, this.totalPages, this.hasPrevPage, this.hasNextPage, this.totalDocs);

  factory MetaModel.fromJson(Map<String, dynamic> json) =>
      _$MetaModelFromJson(json);


}