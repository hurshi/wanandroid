// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MpWechatModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MpWechatModel _$MpWechatModelFromJson(Map<String, dynamic> json) {
  return MpWechatModel(
      (json['children'] as List)?.map((e) => e as String)?.toList(),
      json['courseId'] as int,
      json['id'] as int,
      json['name'] as String,
      json['order'] as int,
      json['parentChapterId'] as int,
      json['userControlSetTop'] as bool,
      json['visible'] as int);
}

Map<String, dynamic> _$MpWechatModelToJson(MpWechatModel instance) =>
    <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible
    };
