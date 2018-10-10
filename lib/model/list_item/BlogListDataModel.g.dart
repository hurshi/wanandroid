// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BlogListDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogListDataModel _$BlogListDataModelFromJson(Map<String, dynamic> json) {
  return BlogListDataModel(
      json['curpage'] as int,
      (json['datas'] as List)
          ?.map((e) => e == null
              ? null
              : BlogListDataItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['offset'] as int,
      json['over'] as bool,
      json['pageCount'] as int,
      json['size'] as int,
      json['total'] as int);
}

Map<String, dynamic> _$BlogListDataModelToJson(BlogListDataModel instance) =>
    <String, dynamic>{
      'curpage': instance.curpage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total
    };
