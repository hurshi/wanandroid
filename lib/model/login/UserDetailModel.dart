import 'package:json_annotation/json_annotation.dart';

part 'UserDetailModel.g.dart';

@JsonSerializable()
class UserDetailModel {
  List<String> chapterTops;
  List<int> collectIds;
  String email;
  String icon;
  int id;
  String password;
  String token;
  int type;
  String username;

  UserDetailModel(this.chapterTops, this.collectIds, this.email, this.icon,
      this.id, this.password, this.token, this.type, this.username);

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailModelFromJson(json);
}
