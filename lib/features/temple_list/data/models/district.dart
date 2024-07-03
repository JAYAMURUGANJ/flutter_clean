// To parse this JSON data, do
//
//     final districtEntity = districtEntityFromMap(jsonString);

import 'dart:convert';

import '../../domain/entities/district_entity.dart';

class District extends DistrictEntity {
  const District({
    final String? stateCode,
    final String? districtCode,
    final String? districtName,
    String? errorCode,
    String? responseDesc,
  }) : super(
          stateCode: stateCode,
          districtCode: districtCode,
          districtName: districtName,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory District.fromJson(String str) => District.fromMap(json.decode(str));

  factory District.fromMap(Map<String, dynamic> json) => District(
        stateCode: json["state_code"],
        districtCode: json["district_code"],
        districtName: json["district_name"],
        errorCode: json["error_code"],
        responseDesc: json["response_desc"],
      );
}
