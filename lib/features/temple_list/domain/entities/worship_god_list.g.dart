// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worship_god_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorshipGodEntity _$WorshipGodEntityFromJson(Map<String, dynamic> json) =>
    WorshipGodEntity(
      worshipCode: json['worship_code'] as int?,
      worshipDesc: json['worship_desc'] as String?,
      tworshipDesc: json['tworship_desc'] as String?,
      imgfileInfo: (json['imgfile_info'] as List<dynamic>?)
          ?.map((e) => ImgfileInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$WorshipGodEntityToJson(WorshipGodEntity instance) =>
    <String, dynamic>{
      'worship_code': instance.worshipCode,
      'worship_desc': instance.worshipDesc,
      'tworship_desc': instance.tworshipDesc,
      'imgfile_info': instance.imgfileInfo,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };

ImgfileInfo _$ImgfileInfoFromJson(Map<String, dynamic> json) => ImgfileInfo(
      fileLocation: json['file_location'] as String?,
    );

Map<String, dynamic> _$ImgfileInfoToJson(ImgfileInfo instance) =>
    <String, dynamic>{
      'file_location': instance.fileLocation,
    };
