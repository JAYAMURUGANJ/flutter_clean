// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_by_temples.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearByTemplesEntity _$NearByTemplesEntityFromJson(Map<String, dynamic> json) =>
    NearByTemplesEntity(
      locationDesc: json['location_desc'] as String?,
      locationFrom: json['location_from'] as String?,
      distance: json['distance'] as String?,
      blueprintImage: json['blueprint_image'] as List<dynamic>?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$NearByTemplesEntityToJson(
        NearByTemplesEntity instance) =>
    <String, dynamic>{
      'location_desc': instance.locationDesc,
      'location_from': instance.locationFrom,
      'distance': instance.distance,
      'blueprint_image': instance.blueprintImage,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };
