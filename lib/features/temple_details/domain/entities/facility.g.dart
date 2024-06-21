// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityEntity _$FacilityEntityFromJson(Map<String, dynamic> json) =>
    FacilityEntity(
      templeid: json['templeid'] as String?,
      templeId: json['temple_id'] as int?,
      templeName: json['temple_name'] as String?,
      ttempleName: json['ttemple_name'] as String?,
      facilityTitle: json['facility_title'] as String?,
      facilityLocation: json['facility_location'] as String?,
      facilityDesc: json['facility_desc'] as String?,
      noofFacilities: json['noof_facilities'] as String?,
      facilityImage: (json['facility_image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      contactPerson: json['contact_person'] as String?,
      contactNo: json['contact_no'] as String?,
      maintowerImage: (json['maintower_image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$FacilityEntityToJson(FacilityEntity instance) =>
    <String, dynamic>{
      'templeid': instance.templeid,
      'temple_id': instance.templeId,
      'temple_name': instance.templeName,
      'ttemple_name': instance.ttempleName,
      'facility_title': instance.facilityTitle,
      'facility_location': instance.facilityLocation,
      'facility_desc': instance.facilityDesc,
      'noof_facilities': instance.noofFacilities,
      'facility_image': instance.facilityImage,
      'contact_person': instance.contactPerson,
      'contact_no': instance.contactNo,
      'maintower_image': instance.maintowerImage,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      fileLocation: json['file_location'] as String?,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'file_location': instance.fileLocation,
    };
