import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/model/RootModel.dart';

import 'WeChatItemModel.dart';

part 'WeChatModel.g.dart';

@JsonSerializable()
class WeChatModel extends RootModel<List<WeChatItemModel>> {
  WeChatModel(List<WeChatItemModel> data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory WeChatModel.fromJson(Map<String, dynamic> json) =>
      _$WeChatModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$WeChatModelToJson(this);
  }
}
