// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorshipEntity _$WorshipEntityFromJson(Map<String, dynamic> json) =>
    WorshipEntity(
      worshipCode: (json['worship_code'] as num?)?.toInt(),
      worshipDesc: json['worship_desc'] as String?,
      tworshipDesc: json['tworship_desc'] as String?,
    );

Map<String, dynamic> _$WorshipEntityToJson(WorshipEntity instance) =>
    <String, dynamic>{
      'worship_code': instance.worshipCode,
      'worship_desc': instance.worshipDesc,
      'tworship_desc': instance.tworshipDesc,
    };
