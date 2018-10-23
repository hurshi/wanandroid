import 'package:json_annotation/json_annotation.dart';

part 'KnowledgeSystemsChildModel.g.dart';

@JsonSerializable()
class KnowledgeSystemsChildModel {
  List<String> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  int visible;

  KnowledgeSystemsChildModel(this.children, this.courseId, this.id, this.name,
      this.order, this.parentChapterId, this.visible);

  factory KnowledgeSystemsChildModel.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeSystemsChildModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$KnowledgeSystemsChildModelToJson(this);
  }
}
