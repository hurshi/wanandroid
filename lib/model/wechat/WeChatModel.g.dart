// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeChatModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeChatModel _$WeChatModelFromJson(Map<String, dynamic> json) {
  return WeChatModel(
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : WeChatItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$WeChatModelToJson(WeChatModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
