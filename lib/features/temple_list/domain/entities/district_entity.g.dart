// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictEntity _$DistrictEntityFromJson(Map<String, dynamic> json) =>
    DistrictEntity(
      stateCode: json['state_code'] as String?,
      districtCode: json['district_code'] as String?,
      districtName: json['district_name'] as String?,
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$DistrictEntityToJson(DistrictEntity instance) =>
    <String, dynamic>{
      'state_code': instance.stateCode,
      'district_code': instance.districtCode,
      'district_name': instance.districtName,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };
