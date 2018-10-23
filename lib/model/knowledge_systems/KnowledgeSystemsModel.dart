import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/model/RootModel.dart';

import 'KnowledgeSystemsParentModel.dart';

part 'KnowledgeSystemsModel.g.dart';

@JsonSerializable()
class KnowledgeSystemsModel
    extends RootModel<List<KnowledgeSystemsParentModel>> {
  KnowledgeSystemsModel(
      List<KnowledgeSystemsParentModel> data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory KnowledgeSystemsModel.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeSystemsModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$KnowledgeSystemsModelToJson(this);
  }
}
