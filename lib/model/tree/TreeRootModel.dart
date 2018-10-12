import 'package:json_annotation/json_annotation.dart';
import 'TreeSecondModel.dart';

part 'TreeRootModel.g.dart';

@JsonSerializable()
class TreeRootModel {
  List<TreeSecondModel> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  int visible;

  TreeRootModel(this.children, this.courseId, this.id, this.name, this.order,
      this.parentChapterId, this.visible);

  factory TreeRootModel.fromJson(Map<String, dynamic> json) =>
      _$TreeRootModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$TreeRootModelToJson(this);
  }
}
