import 'package:wanandroid/model/RootModel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'TreeRootModel.dart';

part 'TreeModel.g.dart';

@JsonSerializable()
class TreeModel extends RootModel<List<TreeRootModel>> {
  TreeModel(List<TreeRootModel> data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory TreeModel.fromJson(Map<String, dynamic> json) =>
      _$TreeModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$TreeModelToJson(this);
  }
}
