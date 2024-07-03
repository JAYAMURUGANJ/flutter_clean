// To parse this JSON data, do
//
//     final districtEntity = districtEntityFromMap(jsonString);

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'district_entity.g.dart';

@JsonSerializable()
class DistrictEntity extends Equatable {
  @JsonKey(name: "state_code")
  final String? stateCode;
  @JsonKey(name: "district_code")
  final String? districtCode;
  @JsonKey(name: "district_name")
  final String? districtName;
  @JsonKey(name: "error_code")
  final String? errorCode;
  @JsonKey(name: "response_desc")
  final String? responseDesc;

  const DistrictEntity({
    this.stateCode,
    this.districtCode,
    this.districtName,
    this.errorCode,
    this.responseDesc,
  });

  factory DistrictEntity.fromJson(Map<String, dynamic> json) =>
      _$DistrictEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictEntityToJson(this);

  @override
  List<Object?> get props {
    return [
      stateCode,
      districtCode,
      districtName,
      errorCode,
      responseDesc,
      errorCode,
      responseDesc,
    ];
  }
}
