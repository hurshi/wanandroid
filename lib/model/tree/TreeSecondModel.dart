import 'package:json_annotation/json_annotation.dart';

part 'TreeSecondModel.g.dart';

@JsonSerializable()
class TreeSecondModel {
  List<String> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  int visible;

  TreeSecondModel(this.children, this.courseId, this.id, this.name, this.order,
      this.parentChapterId, this.visible);

  factory TreeSecondModel.fromJson(Map<String, dynamic> json) =>
      _$TreeSecondModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$TreeSecondModelToJson(this);
  }
}
