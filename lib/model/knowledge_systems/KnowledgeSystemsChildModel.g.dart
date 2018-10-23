// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'KnowledgeSystemsChildModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgeSystemsChildModel _$KnowledgeSystemsChildModelFromJson(
    Map<String, dynamic> json) {
  return KnowledgeSystemsChildModel(
      (json['children'] as List)?.map((e) => e as String)?.toList(),
      json['courseId'] as int,
      json['id'] as int,
      json['name'] as String,
      json['order'] as int,
      json['parentChapterId'] as int,
      json['visible'] as int);
}

Map<String, dynamic> _$KnowledgeSystemsChildModelToJson(
        KnowledgeSystemsChildModel instance) =>
    <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'visible': instance.visible
    };
