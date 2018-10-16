// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BlogListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogListModel _$BlogListModelFromJson(Map<String, dynamic> json) {
  return BlogListModel(
      json['data'] == null
          ? null
          : BlogListDataModel.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$BlogListModelToJson(BlogListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
