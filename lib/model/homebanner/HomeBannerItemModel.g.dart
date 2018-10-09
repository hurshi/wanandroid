// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeBannerItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBannerItemModel _$HomeBannerItemModelFromJson(Map<String, dynamic> json) {
  return HomeBannerItemModel(
      json['desc'] as String,
      json['id'] as int,
      json['imagePath'] as String,
      json['isVisible'] as int,
      json['order'] as int,
      json['title'] as String,
      json['type'] as int,
      json['url'] as String);
}

Map<String, dynamic> _$HomeBannerItemModelToJson(
        HomeBannerItemModel instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'id': instance.id,
      'imagePath': instance.imagePath,
      'isVisible': instance.isVisible,
      'order': instance.order,
      'title': instance.title,
      'type': instance.type,
      'url': instance.url
    };
