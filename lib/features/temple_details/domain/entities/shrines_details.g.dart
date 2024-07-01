// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shrines_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShrinesDetailsEntity _$ShrinesDetailsEntityFromJson(
        Map<String, dynamic> json) =>
    ShrinesDetailsEntity(
      subshrineName: json['subshrine_name'] as String?,
      subshrineDesc: json['subshrine_desc'] as String?,
      specialityDesc: json['speciality_desc'] as String?,
      statusDesc: json['status_desc'] as String?,
      subshrineImage: (json['subshrine_image'] as List<dynamic>?)
          ?.map((e) => SubshrineImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$ShrinesDetailsEntityToJson(
        ShrinesDetailsEntity instance) =>
    <String, dynamic>{
      'subshrine_name': instance.subshrineName,
      'subshrine_desc': instance.subshrineDesc,
      'speciality_desc': instance.specialityDesc,
      'status_desc': instance.statusDesc,
      'subshrine_image': instance.subshrineImage,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };

SubshrineImage _$SubshrineImageFromJson(Map<String, dynamic> json) =>
    SubshrineImage(
      fileLocation: json['file_location'] as String?,
    );

Map<String, dynamic> _$SubshrineImageToJson(SubshrineImage instance) =>
    <String, dynamic>{
      'file_location': instance.fileLocation,
    };
