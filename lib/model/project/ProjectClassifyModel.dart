import 'package:wanandroid/model/RootModel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/model/project/ProjectClassifyItemModel.dart';

part 'ProjectClassifyModel.g.dart';

@JsonSerializable()
class ProjectClassifyModel extends RootModel<List<ProjectClassifyItemModel>> {
  ProjectClassifyModel(
      List<ProjectClassifyItemModel> data, int errorcode, String errormsg)
      : super(data, errorcode, errormsg);

  factory ProjectClassifyModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectClassifyModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ProjectClassifyModelToJson(this);
  }
}
