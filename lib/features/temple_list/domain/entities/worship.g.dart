// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorshipEntity _$WorshipEntityFromJson(Map<String, dynamic> json) =>
    WorshipEntity(
      worshipCode: json['worship_code'] as int?,
      worshipDesc: json['worship_desc'] as String?,
      tworshipDesc: json['tworship_desc'] as String?,
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$WorshipEntityToJson(WorshipEntity instance) =>
    <String, dynamic>{
      'worship_code': instance.worshipCode,
      'worship_desc': instance.worshipDesc,
      'tworship_desc': instance.tworshipDesc,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };
