import 'package:json_annotation/json_annotation.dart';

part 'rate_grid_novel_model.g.dart';

@JsonSerializable()
class RateGridNovelModel {
  final int? total;
  final int? avg;

  RateGridNovelModel(this.total, this.avg);

  factory RateGridNovelModel.fromJson(Map<String, dynamic> json) =>
      _$RateGridNovelModelFromJson(json);

}