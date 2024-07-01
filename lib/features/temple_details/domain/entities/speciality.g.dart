// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialityEntity _$SpecialityEntityFromJson(Map<String, dynamic> json) =>
    SpecialityEntity(
      specialityDesc: json['speciality_desc'] as String?,
      specialityDetails: json['speciality_details'] as String?,
      specialityTitle: json['speciality_title'] as String?,
      specialityImage: (json['speciality_image'] as List<dynamic>?)
          ?.map((e) => SpecialityImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$SpecialityEntityToJson(SpecialityEntity instance) =>
    <String, dynamic>{
      'speciality_desc': instance.specialityDesc,
      'speciality_details': instance.specialityDetails,
      'speciality_title': instance.specialityTitle,
      'speciality_image': instance.specialityImage,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };

SpecialityImage _$SpecialityImageFromJson(Map<String, dynamic> json) =>
    SpecialityImage(
      fileLocation: json['file_location'] as String?,
    );

Map<String, dynamic> _$SpecialityImageToJson(SpecialityImage instance) =>
    <String, dynamic>{
      'file_location': instance.fileLocation,
    };
