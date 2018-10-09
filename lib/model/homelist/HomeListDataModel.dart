import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/model/homelist/HomeListDataItemModel.dart';

part 'HomeListDataModel.g.dart';

@JsonSerializable()
class HomeListDataModel {
  int curpage;
  List<HomeListDataItemModel> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  HomeListDataModel(this.curpage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);

  factory HomeListDataModel.fromJson(Map<String, dynamic> json) =>
      _$HomeListDataModelFromJson(json);
}
