import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'temple_timing.g.dart';

@JsonSerializable()
class TempleTimingEntity extends Equatable {
  @JsonKey(name: "mrng_openingtime")
  final String? mrngOpeningtime;
  @JsonKey(name: "mrng_closing_time")
  final String? mrngClosingTime;
  @JsonKey(name: "evng_opening_time")
  final String? evngOpeningTime;
  @JsonKey(name: "evng_closing_time")
  final String? evngClosingTime;
  @JsonKey(name: "remarks")
  final String? remarks;
  // @JsonKey(name: "closing_time")
  // final List<ClosingTime>? closingTime;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const TempleTimingEntity({
    this.mrngOpeningtime,
    this.mrngClosingTime,
    this.evngOpeningTime,
    this.evngClosingTime,
    this.remarks,
    // this.closingTime,
    this.errorCode,
    this.responseDesc,
  });

  factory TempleTimingEntity.fromJson(Map<String, dynamic> json) =>
      _$TempleTimingEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TempleTimingEntityToJson(this);
  @override
  List<Object?> get props {
    return [
      mrngOpeningtime,
      mrngClosingTime,
      evngOpeningTime,
      evngClosingTime,
      remarks,
      // closingTime,
      errorCode,
      responseDesc,
    ];
  }
}

@JsonSerializable()
class ClosingTime {
  @JsonKey(name: "to_time")
  String? toTime;
  @JsonKey(name: "order_no")
  int? orderNo;
  @JsonKey(name: "from_time")
  String? fromTime;

  ClosingTime({
    this.toTime,
    this.orderNo,
    this.fromTime,
  });

  factory ClosingTime.fromJson(Map<String, dynamic> json) =>
      _$ClosingTimeFromJson(json);

  Map<String, dynamic> toJson() => _$ClosingTimeToJson(this);
}
