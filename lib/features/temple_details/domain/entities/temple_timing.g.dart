// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temple_timing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TempleTimingEntity _$TempleTimingEntityFromJson(Map<String, dynamic> json) =>
    TempleTimingEntity(
      mrngOpeningtime: json['mrng_openingtime'] as String?,
      mrngClosingTime: json['mrng_closing_time'] as String?,
      evngOpeningTime: json['evng_opening_time'] as String?,
      evngClosingTime: json['evng_closing_time'] as String?,
      remarks: json['remarks'] as String?,
      // closingTime: (json['closing_time'] as List<dynamic>?)
      //     ?.map((e) => ClosingTime.fromJson(e as Map<String, dynamic>))
      //     .toList(),
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$TempleTimingEntityToJson(TempleTimingEntity instance) =>
    <String, dynamic>{
      'mrng_openingtime': instance.mrngOpeningtime,
      'mrng_closing_time': instance.mrngClosingTime,
      'evng_opening_time': instance.evngOpeningTime,
      'evng_closing_time': instance.evngClosingTime,
      'remarks': instance.remarks,
      // 'closing_time': instance.closingTime,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };

ClosingTime _$ClosingTimeFromJson(Map<String, dynamic> json) => ClosingTime(
      toTime: json['to_time'] as String?,
      orderNo: json['order_no'] as int?,
      fromTime: json['from_time'] as String?,
    );

Map<String, dynamic> _$ClosingTimeToJson(ClosingTime instance) =>
    <String, dynamic>{
      'to_time': instance.toTime,
      'order_no': instance.orderNo,
      'from_time': instance.fromTime,
    };
