import 'package:json_annotation/json_annotation.dart';
import 'BlogListDataItemTagModel.dart';

part 'BlogListDataItemModel.g.dart';

@JsonSerializable()
class BlogListDataItemModel {
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
  List<BlogListDataItemTagModel> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  BlogListDataItemModel(
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

  factory BlogListDataItemModel.fromJson(Map<String, dynamic> json) =>
      _$BlogListDataItemModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$BlogListDataItemModelToJson(this);
  }
}
