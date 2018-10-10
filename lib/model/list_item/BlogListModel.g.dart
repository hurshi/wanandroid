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
      json['errorcode'] as int,
      json['errormsg'] as String);
}

Map<String, dynamic> _$BlogListModelToJson(BlogListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorcode': instance.errorcode,
      'errormsg': instance.errormsg
    };
