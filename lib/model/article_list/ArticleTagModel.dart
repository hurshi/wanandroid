import 'package:json_annotation/json_annotation.dart';

part 'ArticleTagModel.g.dart';

@JsonSerializable()
class ArticleTagModel {
  String name;
  String url;

  ArticleTagModel(this.name, this.url);

  factory ArticleTagModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleTagModelFromJson(json);
}
