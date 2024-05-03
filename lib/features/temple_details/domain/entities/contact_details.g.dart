// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDetailsEntity _$ContactDetailsEntityFromJson(
        Map<String, dynamic> json) =>
    ContactDetailsEntity(
      templeName: json['temple_name'] as String?,
      templeDoorno: json['temple_doorno'] as String?,
      templeStreet: json['temple_street'] as String?,
      templeLocation: json['temple_location'] as String?,
      pincode: json['pincode'] as String?,
      landline: json['landline'] as String?,
      email: json['email'] as String?,
      districtName: json['district_name'] as String?,
      username: json['username'] as String?,
      designationDesc: json['designation_desc'] as String?,
      prefixDesc: json['prefix_desc'] as String?,
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$ContactDetailsEntityToJson(
        ContactDetailsEntity instance) =>
    <String, dynamic>{
      'temple_name': instance.templeName,
      'temple_doorno': instance.templeDoorno,
      'temple_street': instance.templeStreet,
      'temple_location': instance.templeLocation,
      'pincode': instance.pincode,
      'landline': instance.landline,
      'email': instance.email,
      'district_name': instance.districtName,
      'username': instance.username,
      'designation_desc': instance.designationDesc,
      'prefix_desc': instance.prefixDesc,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };
