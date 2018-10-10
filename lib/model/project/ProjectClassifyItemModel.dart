import 'package:json_annotation/json_annotation.dart';

part 'ProjectClassifyItemModel.g.dart';

@JsonSerializable()
class ProjectClassifyItemModel {
  List<String> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  int visible;
  String url;

  ProjectClassifyItemModel(
      {this.children,
      this.courseId,
      this.id,
      String name,
      this.order,
      this.parentChapterId,
      this.visible,
      this.url}) {
    this.name = name.replaceAll("&amp;", "&");
  }

  factory ProjectClassifyItemModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectClassifyItemModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ProjectClassifyItemModelToJson(this);
  }
}
