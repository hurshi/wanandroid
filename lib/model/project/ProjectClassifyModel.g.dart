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
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$ProjectClassifyModelToJson(
        ProjectClassifyModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
