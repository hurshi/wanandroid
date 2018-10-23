import 'package:json_annotation/json_annotation.dart';

part 'WeChatModel.g.dart';

@JsonSerializable()
class WeChatModel {
  List<String> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  WeChatModel(this.children, this.courseId, this.id, this.name, this.order,
      this.parentChapterId, this.userControlSetTop, this.visible);

  factory WeChatModel.fromJson(Map<String, dynamic> json) =>
      _$WeChatModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$WeChatModelToJson(this);
  }
}
