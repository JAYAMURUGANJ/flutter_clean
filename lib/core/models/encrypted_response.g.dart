// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encrypted_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncryptedResponse _$EncryptedResponseFromJson(Map<String, dynamic> json) =>
    EncryptedResponse(
      resultSet: json['result_set'],
      responseStatus: json['response_status'] as String?,
    );

Map<String, dynamic> _$EncryptedResponseToJson(EncryptedResponse instance) =>
    <String, dynamic>{
      'result_set': instance.resultSet,
      'response_status': instance.responseStatus,
    };
