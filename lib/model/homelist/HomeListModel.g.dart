// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeListModel _$HomeListModelFromJson(Map<String, dynamic> json) {
  return HomeListModel(
      json['data'] == null
          ? null
          : HomeListDataModel.fromJson(json['data'] as Map<String, dynamic>),
      json['errorcode'] as int,
      json['errormsg'] as String);
}

Map<String, dynamic> _$HomeListModelToJson(HomeListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorcode': instance.errorcode,
      'errormsg': instance.errormsg
    };
