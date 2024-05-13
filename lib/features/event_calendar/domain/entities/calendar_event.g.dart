// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventEntity _$CalendarEventEntityFromJson(Map<String, dynamic> json) =>
    CalendarEventEntity(
      calendarDays: json['calendar_days'] == null
          ? null
          : DateTime.parse(json['calendar_days'] as String),
      festivalData: (json['festival_data'] as List<dynamic>?)
          ?.map((e) => FestivalDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$CalendarEventEntityToJson(
        CalendarEventEntity instance) =>
    <String, dynamic>{
      'calendar_days': instance.calendarDays?.toIso8601String(),
      'festival_data': instance.festivalData,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };

FestivalDatum _$FestivalDatumFromJson(Map<String, dynamic> json) =>
    FestivalDatum(
      noofTemples: json['noof_temples'] as String?,
      festivalCode: json['festival_code'] as String?,
      festivalName: json['festival_name'] as String?,
      festivalDate: json['festival_date'] as String?,
    );

Map<String, dynamic> _$FestivalDatumToJson(FestivalDatum instance) =>
    <String, dynamic>{
      'noof_temples': instance.noofTemples,
      'festival_code': instance.festivalCode,
      'festival_name': instance.festivalName,
      'festival_date': instance.festivalDate,
    };
