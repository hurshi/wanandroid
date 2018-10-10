// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectClassifyItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectClassifyItemModel _$ProjectClassifyItemModelFromJson(
    Map<String, dynamic> json) {
  return ProjectClassifyItemModel(
      children: (json['children'] as List)?.map((e) => e as String)?.toList(),
      courseId: json['courseId'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      order: json['order'] as int,
      parentChapterId: json['parentChapterId'] as int,
      visible: json['visible'] as int,
      url: json['url'] as String);
}

Map<String, dynamic> _$ProjectClassifyItemModelToJson(
        ProjectClassifyItemModel instance) =>
    <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'visible': instance.visible,
      'url': instance.url
    };
