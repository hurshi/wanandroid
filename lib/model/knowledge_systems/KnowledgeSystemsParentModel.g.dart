// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'KnowledgeSystemsParentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgeSystemsParentModel _$KnowledgeSystemsParentModelFromJson(
    Map<String, dynamic> json) {
  return KnowledgeSystemsParentModel(
      (json['children'] as List)
          ?.map((e) => e == null
              ? null
              : KnowledgeSystemsChildModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['courseId'] as int,
      json['id'] as int,
      json['name'] as String,
      json['order'] as int,
      json['parentChapterId'] as int,
      json['visible'] as int);
}

Map<String, dynamic> _$KnowledgeSystemsParentModelToJson(
        KnowledgeSystemsParentModel instance) =>
    <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'visible': instance.visible
    };
