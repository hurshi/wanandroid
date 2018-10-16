import 'package:wanandroid/model/RootModel.dart';
import 'package:wanandroid/model/list_item/BlogListDataModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'BlogListModel.g.dart';

@JsonSerializable()
class BlogListModel extends RootModel<BlogListDataModel> {
  BlogListModel(BlogListDataModel data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory BlogListModel.fromJson(Map<String, dynamic> json) =>
      _$BlogListModelFromJson(json);
}
