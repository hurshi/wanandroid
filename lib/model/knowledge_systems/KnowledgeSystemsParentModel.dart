import 'package:json_annotation/json_annotation.dart';

import 'KnowledgeSystemsChildModel.dart';

part 'KnowledgeSystemsParentModel.g.dart';

@JsonSerializable()
class KnowledgeSystemsParentModel {
  List<KnowledgeSystemsChildModel> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  int visible;

  KnowledgeSystemsParentModel(this.children, this.courseId, this.id, this.name,
      this.order, this.parentChapterId, this.visible);

  factory KnowledgeSystemsParentModel.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeSystemsParentModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$KnowledgeSystemsParentModelToJson(this);
  }
}
