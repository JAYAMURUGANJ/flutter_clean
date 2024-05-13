// To parse this JSON data, do
//
//     final calendarEventEntity = calendarEventEntityFromMap(jsonString);

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event.g.dart';

@JsonSerializable()
class CalendarEventEntity extends Equatable {
  @JsonKey(name: "calendar_days")
  final DateTime? calendarDays;
  @JsonKey(name: "festival_data")
  final List<FestivalDatum>? festivalData;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const CalendarEventEntity({
    this.calendarDays,
    this.festivalData,
    this.errorCode,
    this.responseDesc,
  });

  factory CalendarEventEntity.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventEntityToJson(this);

  @override
  List<Object?> get props {
    return [
      calendarDays,
      festivalData,
    ];
  }
}

@JsonSerializable()
class FestivalDatum extends Equatable {
  @JsonKey(name: "noof_temples")
  final String? noofTemples;
  @JsonKey(name: "festival_code")
  final String? festivalCode;
  @JsonKey(name: "festival_name")
  final String? festivalName;
  @JsonKey(name: "festival_date")
  final String? festivalDate;

  const FestivalDatum({
    this.noofTemples,
    this.festivalCode,
    this.festivalName,
    this.festivalDate,
  });

  factory FestivalDatum.fromJson(Map<String, dynamic> json) =>
      _$FestivalDatumFromJson(json);

  Map<String, dynamic> toJson() => _$FestivalDatumToJson(this);

  @override
  List<Object?> get props {
    return [
      noofTemples,
      festivalCode,
      festivalName,
      festivalDate,
    ];
  }
}
