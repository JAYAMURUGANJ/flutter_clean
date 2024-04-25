// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whats_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WhatsNewEntity _$WhatsNewEntityFromJson(Map<String, dynamic> json) =>
    WhatsNewEntity(
      dated: json['dated'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      whatsnewImages: (json['whatsnew_images'] as List<dynamic>?)
          ?.map((e) => WhatsnewImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$WhatsNewEntityToJson(WhatsNewEntity instance) =>
    <String, dynamic>{
      'dated': instance.dated,
      'title': instance.title,
      'description': instance.description,
      'whatsnew_images': instance.whatsnewImages,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };

WhatsnewImage _$WhatsnewImageFromJson(Map<String, dynamic> json) =>
    WhatsnewImage(
      fileLocation: json['file_location'] as String?,
    );

Map<String, dynamic> _$WhatsnewImageToJson(WhatsnewImage instance) =>
    <String, dynamic>{
      'file_location': instance.fileLocation,
    };
