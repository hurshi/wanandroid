import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/model/article_list/ArticleItemModel.dart';

part 'ArticleListDataModel.g.dart';

@JsonSerializable()
class ArticleListDataModel {
  int curpage;
  List<ArticleItemModel> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  ArticleListDataModel(this.curpage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);

  factory ArticleListDataModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleListDataModelFromJson(json);
}
