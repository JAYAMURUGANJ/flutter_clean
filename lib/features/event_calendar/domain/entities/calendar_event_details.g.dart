// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventDetailsEntity _$CalendarEventDetailsEntityFromJson(
        Map<String, dynamic> json) =>
    CalendarEventDetailsEntity(
      templeId: json['temple_id'] as int?,
      templeName: json['temple_name'] as String?,
      festivalId: json['festival_id'] as int?,
      festivalFrom: json['festival_from'] == null
          ? null
          : DateTime.parse(json['festival_from'] as String),
      festivalTo: json['festival_to'] == null
          ? null
          : DateTime.parse(json['festival_to'] as String),
      festivalName: json['festival_name'] as String?,
      nakshatraDesc: json['nakshatra_desc'],
      thithiDesc: json['thithi_desc'],
      typeDesc: json['type_desc'],
      festivalInfo: (json['festival_info'] as List<dynamic>?)
          ?.map((e) => FestivalInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$CalendarEventDetailsEntityToJson(
        CalendarEventDetailsEntity instance) =>
    <String, dynamic>{
      'temple_id': instance.templeId,
      'temple_name': instance.templeName,
      'festival_id': instance.festivalId,
      'festival_from': instance.festivalFrom?.toIso8601String(),
      'festival_to': instance.festivalTo?.toIso8601String(),
      'festival_name': instance.festivalName,
      'nakshatra_desc': instance.nakshatraDesc,
      'thithi_desc': instance.thithiDesc,
      'type_desc': instance.typeDesc,
      'festival_info': instance.festivalInfo,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };

FestivalInfo _$FestivalInfoFromJson(Map<String, dynamic> json) => FestivalInfo(
      festivalDate: json['festival_date'] == null
          ? null
          : DateTime.parse(json['festival_date'] as String),
      festivalTotime: json['festival_totime'] as String?,
      festivalDetails: json['festival_details'] as String?,
      festivalFromtime: json['festival_fromtime'] as String?,
    );

Map<String, dynamic> _$FestivalInfoToJson(FestivalInfo instance) =>
    <String, dynamic>{
      'festival_date': instance.festivalDate?.toIso8601String(),
      'festival_totime': instance.festivalTotime,
      'festival_details': instance.festivalDetails,
      'festival_fromtime': instance.festivalFromtime,
    };
