// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sculptures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SculpturesEntity _$SculptureEntityFromJson(Map<String, dynamic> json) =>
    SculpturesEntity(
      sculpturesName: json['sculptures_name'] as String?,
      sculptureDesc: json['sculpture_desc'] as String?,
      sculptureInfo: (json['sculpture_info'] as List<dynamic>?)
          ?.map((e) => SculptureInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SculptureEntityToJson(SculpturesEntity instance) =>
    <String, dynamic>{
      'sculptures_name': instance.sculpturesName,
      'sculpture_desc': instance.sculptureDesc,
      'sculpture_info': instance.sculptureInfo,
    };

SculptureInfo _$SculptureInfoFromJson(Map<String, dynamic> json) =>
    SculptureInfo(
      fileLocation: json['file_location'] as String?,
    );

Map<String, dynamic> _$SculptureInfoToJson(SculptureInfo instance) =>
    <String, dynamic>{
      'file_location': instance.fileLocation,
    };
