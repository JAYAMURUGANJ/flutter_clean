// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temple_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TempleInfoEntity _$TempleInfoEntityFromJson(Map<String, dynamic> json) =>
    TempleInfoEntity(
      description: json['description'] as String?,
      moolavarSwamiName: json['moolavar_swami_name'] as String?,
      moolavarAmbalName: json['moolavar_ambal_name'] as String?,
      aagamamDesc: json['aagamam_desc'],
      poetName: json['poet_name'] as String?,
      historicalName: json['historical_name'],
      sthalaVirutcham: json['sthala_virutcham'] as String?,
      templeTheertham: json['temple_theertham'] as String?,
      templeImages: (json['temple_images'] as List<dynamic>?)
          ?.map((e) => TempleImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$TempleInfoEntityToJson(TempleInfoEntity instance) =>
    <String, dynamic>{
      'description': instance.description,
      'moolavar_swami_name': instance.moolavarSwamiName,
      'moolavar_ambal_name': instance.moolavarAmbalName,
      'aagamam_desc': instance.aagamamDesc,
      'poet_name': instance.poetName,
      'historical_name': instance.historicalName,
      'sthala_virutcham': instance.sthalaVirutcham,
      'temple_theertham': instance.templeTheertham,
      'temple_images': instance.templeImages,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };

TempleImage _$TempleImageFromJson(Map<String, dynamic> json) => TempleImage(
      fileLocation: json['file_location'] as String?,
    );

Map<String, dynamic> _$TempleImageToJson(TempleImage instance) =>
    <String, dynamic>{
      'file_location': instance.fileLocation,
    };
