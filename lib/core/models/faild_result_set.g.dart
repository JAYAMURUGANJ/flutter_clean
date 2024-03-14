// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faild_result_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponceStatus _$ResponceStatusFromJson(Map<String, dynamic> json) =>
    ResponceStatus(
      errorCode: json['error_code'],
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$ResponceStatusToJson(ResponceStatus instance) =>
    <String, dynamic>{
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };
