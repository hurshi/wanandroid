import 'package:json_annotation/json_annotation.dart';

part 'HomeListDataItemTagModel.g.dart';

@JsonSerializable()
class HomeListDataItemTagModel {
  String name;
  String url;

  HomeListDataItemTagModel(this.name, this.url);

  factory HomeListDataItemTagModel.fromJson(Map<String, dynamic> json) =>
      _$HomeListDataItemTagModelFromJson(json);
}
