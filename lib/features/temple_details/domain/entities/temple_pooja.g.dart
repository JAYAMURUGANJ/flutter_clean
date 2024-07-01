// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temple_pooja.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplePoojaEntity _$TemplePoojaEntityFromJson(Map<String, dynamic> json) =>
    TemplePoojaEntity(
      poojaDesc: json['pooja_desc'] as String?,
      alangaram: json['alangaram'] as String?,
      poojaTime: json['pooja_time'] as String?,
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$TemplePoojaEntityToJson(TemplePoojaEntity instance) =>
    <String, dynamic>{
      'pooja_desc': instance.poojaDesc,
      'alangaram': instance.alangaram,
      'pooja_time': instance.poojaTime,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };
