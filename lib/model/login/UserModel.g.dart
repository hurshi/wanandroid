// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
      json['data'] == null
          ? null
          : UserDetailModel.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
