import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/model/RootModel.dart';

part 'EmptyModel.g.dart';

@JsonSerializable()
class EmptyModel extends RootModel<dynamic> {
  EmptyModel(dynamic data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory EmptyModel.fromJson(Map<String, dynamic> json) =>
      _$EmptyModelFromJson(json);

  toJson() => _$EmptyModelToJson(this);
}
