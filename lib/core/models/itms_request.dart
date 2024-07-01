import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'itms_request.g.dart';

String itmsRequestToJson(List<ITMSRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class ITMSRequest {
  @JsonKey(name: 'adparam')
  List<Adparam> adparam;
  @JsonKey(name: 'ipaddress')
  List<Ipaddress> ipaddress;
  @JsonKey(name: 'lang_type')
  String langType;
  @JsonKey(name: 'service_id')
  String serviceId;
  @JsonKey(name: 'filter_data')
  List<FilterData>? filterData;
  @JsonKey(name: 'request_time')
  String requestTime;
  @JsonKey(name: 'version_date')
  String versionDate;
  @JsonKey(name: 'version_number')
  String versionNumber;
  @JsonKey(name: 'requestor_userid')
  String requestorUserid;
  @JsonKey(name: 'requestor_userpwd')
  String requestorUserpwd;
  @JsonKey(name: 'service_requester')
  String serviceRequester;
  ITMSRequest({
    required this.adparam,
    required this.ipaddress,
    required this.langType,
    required this.serviceId,
    this.filterData,
    required this.requestTime,
    required this.versionDate,
    required this.versionNumber,
    required this.requestorUserid,
    required this.requestorUserpwd,
    required this.serviceRequester,
  });

  factory ITMSRequest.fromJson(Map<String, dynamic> json) =>
      _$ITMSRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ITMSRequestToJson(this);
}

@JsonSerializable()
class Adparam {
  @JsonKey(name: 'device_time')
  String deviceTime;
  @JsonKey(name: 'server_time')
  String serverTime;

  Adparam({required this.deviceTime, required this.serverTime});

  factory Adparam.fromJson(Map<String, dynamic> json) =>
      _$AdparamFromJson(json);

  Map<String, dynamic> toJson() => _$AdparamToJson(this);
}

@JsonSerializable()
class Ipaddress {
  @JsonKey(name: 'ip')
  String ip;
  @JsonKey(name: 'device_id')
  String deviceId;
  @JsonKey(name: 'device_name')
  String deviceName;
  Ipaddress({
    required this.ip,
    required this.deviceId,
    required this.deviceName,
  });

  factory Ipaddress.fromJson(Map<String, dynamic> json) =>
      _$IpaddressFromJson(json);

  Map<String, dynamic> toJson() => _$IpaddressToJson(this);
}

@JsonSerializable()
class FilterData {
  @JsonKey(name: 'district_code')
  String? districtCode;
  @JsonKey(name: 'degree360_avail')
  String? degree360Avail;
  @JsonKey(name: 'temple_id')
  String? templeId;
  @JsonKey(name: 'section_code')
  String? sectionCode;
  @JsonKey(name: 'seniorgrade_temples')
  String? seniorgradeTemples;
  @JsonKey(name: 'festival_month')
  String? festivalMonth;
  @JsonKey(name: 'festival_code')
  String? festivalCode;
  @JsonKey(name: 'festival_date')
  String? festivalDate;
  FilterData({
    this.districtCode,
    this.degree360Avail,
    this.templeId,
    this.sectionCode,
    this.seniorgradeTemples,
    this.festivalMonth,
    this.festivalCode,
    this.festivalDate,
  });

  factory FilterData.fromJson(Map<String, dynamic> json) =>
      _$FilterDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDataToJson(this);
}
