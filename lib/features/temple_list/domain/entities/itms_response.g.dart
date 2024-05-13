// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itms_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItmsResponseEntity _$ItmsResponseEntityFromJson(Map<String, dynamic> json) =>
    ItmsResponseEntity(
      templeId: (json['temple_Id'] as num?)?.toInt(),
      templeName: json['temple_name'] as String?,
      ttempleName: json['ttemple_name'] as String?,
      jurisOfficeCode: (json['juris_office_code'] as num?)?.toInt(),
      districtCode: json['district_code'] as String?,
      talukCode: json['taluk_code'] as String?,
      villageCode: json['village_code'] as String?,
      templeTypecode: (json['temple_typecode'] as num?)?.toInt(),
      instituteCategorycode: (json['institute_categorycode'] as num?)?.toInt(),
      templesectionCode: (json['templesection_code'] as num?)?.toInt(),
      managementTypecode: (json['management_typecode'] as num?)?.toInt(),
      managementSubtypecode: (json['management_subtype_code'] as num?)?.toInt(),
      worshipCode: (json['worship_code'] as num?)?.toInt(),
      urlTemplewebsite: json['url_templewebsite'] as String?,
      postalAvail: json['postal_avail'] as String?,
      annadhanamEnabled: json['annadhanam_enabled'] as String?,
      degree360Avail: json['degree360_avail'] as String?,
      degree360view: json['degree_360view'] as String?,
      templeLatitude: json['temple_latitude'] as String?,
      templeLangitude: json['temple_langitude'] as String?,
      maintowerImage: (json['maintower_image'] as List<dynamic>?)
          ?.map((e) => MaintowerImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$ItmsResponseEntityToJson(ItmsResponseEntity instance) =>
    <String, dynamic>{
      'temple_Id': instance.templeId,
      'temple_name': instance.templeName,
      'ttemple_name': instance.ttempleName,
      'juris_office_code': instance.jurisOfficeCode,
      'district_code': instance.districtCode,
      'taluk_code': instance.talukCode,
      'village_code': instance.villageCode,
      'temple_typecode': instance.templeTypecode,
      'institute_categorycode': instance.instituteCategorycode,
      'templesection_code': instance.templesectionCode,
      'management_typecode': instance.managementTypecode,
      'management_subtype_code': instance.managementSubtypecode,
      'worship_code': instance.worshipCode,
      'url_templewebsite': instance.urlTemplewebsite,
      'postal_avail': instance.postalAvail,
      'annadhanam_enabled': instance.annadhanamEnabled,
      'degree360_avail': instance.degree360Avail,
      'degree_360view': instance.degree360view,
      'temple_latitude': instance.templeLatitude,
      'temple_langitude': instance.templeLangitude,
      'maintower_image': instance.maintowerImage,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };

MaintowerImage _$MaintowerImageFromJson(Map<String, dynamic> json) =>
    MaintowerImage(
      fileLocation: json['file_location'] as String?,
    );

Map<String, dynamic> _$MaintowerImageToJson(MaintowerImage instance) =>
    <String, dynamic>{
      'file_location': instance.fileLocation,
    };
