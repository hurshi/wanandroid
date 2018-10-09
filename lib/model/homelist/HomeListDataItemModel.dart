import 'package:json_annotation/json_annotation.dart';
import 'HomeListDataItemTagModel.dart';

part 'HomeListDataItemModel.g.dart';

@JsonSerializable()
class HomeListDataItemModel {
  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String origin;
  String projectLink;
  int publishTime;
  int superChapterId;
  String superChapterName;
  List<HomeListDataItemTagModel> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  HomeListDataItemModel(
      this.apkLink,
      this.author,
      this.chapterId,
      this.chapterName,
      this.collect,
      this.courseId,
      this.desc,
      this.envelopePic,
      this.fresh,
      this.id,
      this.link,
      this.niceDate,
      this.origin,
      this.projectLink,
      this.publishTime,
      this.superChapterId,
      this.superChapterName,
      this.tags,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan);

  factory HomeListDataItemModel.fromJson(Map<String, dynamic> json) =>
      _$HomeListDataItemModelFromJson(json);
}
