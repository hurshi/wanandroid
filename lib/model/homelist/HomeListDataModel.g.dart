// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeListDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeListDataModel _$HomeListDataModelFromJson(Map<String, dynamic> json) {
  return HomeListDataModel(
      json['curpage'] as int,
      (json['datas'] as List)
          ?.map((e) => e == null
              ? null
              : HomeListDataItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['offset'] as int,
      json['over'] as bool,
      json['pageCount'] as int,
      json['size'] as int,
      json['total'] as int);
}

Map<String, dynamic> _$HomeListDataModelToJson(HomeListDataModel instance) =>
    <String, dynamic>{
      'curpage': instance.curpage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total
    };
