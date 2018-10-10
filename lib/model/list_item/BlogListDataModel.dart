import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/model/list_item/BlogListDataItemModel.dart';

part 'BlogListDataModel.g.dart';

@JsonSerializable()
class BlogListDataModel {
  int curpage;
  List<BlogListDataItemModel> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  BlogListDataModel(this.curpage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);

  factory BlogListDataModel.fromJson(Map<String, dynamic> json) =>
      _$BlogListDataModelFromJson(json);
}
