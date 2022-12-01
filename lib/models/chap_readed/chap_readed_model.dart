import 'package:json_annotation/json_annotation.dart';

part 'chap_readed_model.g.dart';

@JsonSerializable()
class ChapterReadModel {
  final String idNovel;
  final List<int> listChapterRead;


  ChapterReadModel({required this.idNovel, required this.listChapterRead});

  factory ChapterReadModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterReadModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterReadModelToJson(this);
}