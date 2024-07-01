// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worship_god_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorshipGodEntity _$WorshipEntityFromJson(Map<String, dynamic> json) =>
    WorshipGodEntity(
      worshipCode: json['worship_code'] as int?,
      worshipDesc: json['worship_desc'] as String?,
      tworshipDesc: json['tworship_desc'] as String?,
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$WorshipEntityToJson(WorshipGodEntity instance) =>
    <String, dynamic>{
      'worship_code': instance.worshipCode,
      'worship_desc': instance.worshipDesc,
      'tworship_desc': instance.tworshipDesc,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };
