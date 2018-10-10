import 'package:json_annotation/json_annotation.dart';

part 'BlogListDataItemTagModel.g.dart';

@JsonSerializable()
class BlogListDataItemTagModel {
  String name;
  String url;

  BlogListDataItemTagModel(this.name, this.url);

  factory BlogListDataItemTagModel.fromJson(Map<String, dynamic> json) =>
      _$BlogListDataItemTagModelFromJson(json);
}
