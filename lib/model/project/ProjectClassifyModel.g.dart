// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectClassifyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectClassifyModel _$ProjectClassifyModelFromJson(Map<String, dynamic> json) {
  return ProjectClassifyModel(
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ProjectClassifyItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorcode'] as int,
      json['errormsg'] as String);
}

Map<String, dynamic> _$ProjectClassifyModelToJson(
        ProjectClassifyModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorcode': instance.errorcode,
      'errormsg': instance.errormsg
    };
