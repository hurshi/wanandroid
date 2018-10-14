import 'package:json_annotation/json_annotation.dart';

part 'MpWechatModel.g.dart';

@JsonSerializable()
class MpWechatModel {
  List<String> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  MpWechatModel(this.children, this.courseId, this.id, this.name, this.order,
      this.parentChapterId, this.userControlSetTop, this.visible);

  factory MpWechatModel.fromJson(Map<String, dynamic> json) =>
      _$MpWechatModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$MpWechatModelToJson(this);
  }
}
