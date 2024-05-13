import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event_details.g.dart';

@JsonSerializable()
class CalendarEventDetailsEntity extends Equatable {
  @JsonKey(name: "temple_id")
  final int? templeId;
  @JsonKey(name: "temple_name")
  final String? templeName;
  @JsonKey(name: "festival_id")
  final int? festivalId;
  @JsonKey(name: "festival_from")
  final DateTime? festivalFrom;
  @JsonKey(name: "festival_to")
  final DateTime? festivalTo;
  @JsonKey(name: "festival_name")
  final String? festivalName;
  @JsonKey(name: "nakshatra_desc")
  final dynamic nakshatraDesc;
  @JsonKey(name: "thithi_desc")
  final dynamic thithiDesc;
  @JsonKey(name: "type_desc")
  final dynamic typeDesc;
  @JsonKey(name: "festival_info")
  final List<FestivalInfo>? festivalInfo;

  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const CalendarEventDetailsEntity({
    this.templeId,
    this.templeName,
    this.festivalId,
    this.festivalFrom,
    this.festivalTo,
    this.festivalName,
    this.nakshatraDesc,
    this.thithiDesc,
    this.typeDesc,
    this.festivalInfo,
    this.errorCode,
    this.responseDesc,
  });

  factory CalendarEventDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventDetailsEntityToJson(this);

  @override
  List<Object?> get props {
    return [
      templeId,
      templeName,
      festivalId,
      festivalFrom,
      festivalTo,
      festivalName,
      nakshatraDesc,
      thithiDesc,
      typeDesc,
      festivalInfo,
    ];
  }
}

@JsonSerializable()
class FestivalInfo {
  @JsonKey(name: "festival_date")
  final DateTime? festivalDate;
  @JsonKey(name: "festival_totime")
  final String? festivalTotime;
  @JsonKey(name: "festival_details")
  final String? festivalDetails;
  @JsonKey(name: "festival_fromtime")
  final String? festivalFromtime;

  FestivalInfo({
    this.festivalDate,
    this.festivalTotime,
    this.festivalDetails,
    this.festivalFromtime,
  });

  factory FestivalInfo.fromJson(Map<String, dynamic> json) =>
      _$FestivalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$FestivalInfoToJson(this);

  @override
  List<Object?> get props {
    return [
      festivalDate,
      festivalTotime,
      festivalDetails,
      festivalFromtime,
    ];
  }
}
