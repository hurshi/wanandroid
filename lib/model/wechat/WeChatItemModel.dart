import 'package:json_annotation/json_annotation.dart';

part 'WeChatItemModel.g.dart';

@JsonSerializable()
class WeChatItemModel {
  List<String> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  WeChatItemModel(this.children, this.courseId, this.id, this.name, this.order,
      this.parentChapterId, this.userControlSetTop, this.visible);

  factory WeChatItemModel.fromJson(Map<String, dynamic> json) =>
      _$WeChatItemModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$WeChatItemModelToJson(this);
  }
}
