import 'package:json_annotation/json_annotation.dart';

part 'HomeBannerItemModel.g.dart';

@JsonSerializable()
class HomeBannerItemModel {
  HomeBannerItemModel(this.desc, this.id, this.imagePath, this.isVisible,
      this.order, this.title, this.type, this.url);

  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  factory HomeBannerItemModel.fromJson(Map<String, dynamic> json) =>
      _$HomeBannerItemModelFromJson(json);
}
