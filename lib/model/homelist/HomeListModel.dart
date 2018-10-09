import 'package:wanandroid/model/RootModel.dart';
import 'package:wanandroid/model/homelist/HomeListDataModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'HomeListModel.g.dart';

@JsonSerializable()
class HomeListModel extends RootModel<HomeListDataModel> {
  HomeListModel(HomeListDataModel data, int errorcode, String errormsg)
      : super(data, errorcode, errormsg);

  factory HomeListModel.fromJson(Map<String, dynamic> json) =>
      _$HomeListModelFromJson(json);
}
