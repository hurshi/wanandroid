// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmptyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmptyModel _$EmptyModelFromJson(Map<String, dynamic> json) {
  return EmptyModel(
      json['data'], json['errorCode'] as int, json['errorMsg'] as String);
}

Map<String, dynamic> _$EmptyModelToJson(EmptyModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
