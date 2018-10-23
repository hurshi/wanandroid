// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'KnowledgeSystemsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgeSystemsModel _$KnowledgeSystemsModelFromJson(
    Map<String, dynamic> json) {
  return KnowledgeSystemsModel(
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : KnowledgeSystemsParentModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$KnowledgeSystemsModelToJson(
        KnowledgeSystemsModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
