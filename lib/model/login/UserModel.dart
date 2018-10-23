import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/model/RootModel.dart';

import 'UserDetailModel.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel extends RootModel<UserDetailModel> {
  UserModel(UserDetailModel data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  toJson() => _$UserModelToJson(this);
}
