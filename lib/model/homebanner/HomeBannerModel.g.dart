// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeBannerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBannerModel _$HomeBannerModelFromJson(Map<String, dynamic> json) {
  return HomeBannerModel(
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : HomeBannerItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$HomeBannerModelToJson(HomeBannerModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
