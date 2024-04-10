// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itms_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ITMSRequest _$ITMSRequestFromJson(Map<String, dynamic> json) => ITMSRequest(
      adparam: (json['adparam'] as List<dynamic>)
          .map((e) => Adparam.fromJson(e as Map<String, dynamic>))
          .toList(),
      ipaddress: (json['ipaddress'] as List<dynamic>)
          .map((e) => Ipaddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      langType: json['lang_type'] as String,
      serviceId: json['service_id'] as String,
      filterData: (json['filter_data'] as List<dynamic>)
          .map((e) => FilterData.fromJson(e as Map<String, dynamic>))
          .toList(),
      requestTime: json['request_time'] as String,
      versionDate: json['version_date'] as String,
      versionNumber: json['version_number'] as String,
      requestorUserid: json['requestor_userid'] as String,
      requestorUserpwd: json['requestor_userpwd'] as String,
      serviceRequester: json['service_requester'] as String,
    );

Map<String, dynamic> _$ITMSRequestToJson(ITMSRequest instance) =>
    <String, dynamic>{
      'adparam': instance.adparam,
      'ipaddress': instance.ipaddress,
      'lang_type': instance.langType,
      'service_id': instance.serviceId,
      'filter_data': instance.filterData,
      'request_time': instance.requestTime,
      'version_date': instance.versionDate,
      'version_number': instance.versionNumber,
      'requestor_userid': instance.requestorUserid,
      'requestor_userpwd': instance.requestorUserpwd,
      'service_requester': instance.serviceRequester,
    };

Adparam _$AdparamFromJson(Map<String, dynamic> json) => Adparam(
      deviceTime: json['device_time'] as String,
      serverTime: json['server_time'] as String,
    );

Map<String, dynamic> _$AdparamToJson(Adparam instance) => <String, dynamic>{
      'device_time': instance.deviceTime,
      'server_time': instance.serverTime,
    };

Ipaddress _$IpaddressFromJson(Map<String, dynamic> json) => Ipaddress(
      ip: json['ip'] as String,
      deviceId: json['device_id'] as String,
      deviceName: json['device_name'] as String,
    );

Map<String, dynamic> _$IpaddressToJson(Ipaddress instance) => <String, dynamic>{
      'ip': instance.ip,
      'device_id': instance.deviceId,
      'device_name': instance.deviceName,
    };

FilterData _$FilterDataFromJson(Map<String, dynamic> json) => FilterData(
      districtCode: json['district_code'] as String?,
      degree360Avail: json['degree360_avail'] as String?,
      templeId: json['temple_id'] as String?,
      sectionCode: json['section_code'] as String?,
      seniorgradeTemples: json['seniorgrade_temples'] as String?,
    );

Map<String, dynamic> _$FilterDataToJson(FilterData instance) =>
    <String, dynamic>{
      'district_code': instance.districtCode,
      'degree360_avail': instance.degree360Avail,
      'temple_id': instance.templeId,
      'section_code': instance.sectionCode,
      'seniorgrade_temples': instance.seniorgradeTemples,
    };
