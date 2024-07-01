import 'dart:convert';

import '/features/temple_details/domain/entities/temple_timing.dart';

class TempleTiming extends TempleTimingEntity {
  const TempleTiming({
    String? mrngOpeningtime,
    String? mrngClosingTime,
    String? evngOpeningTime,
    String? evngClosingTime,
    String? remarks,
    String? errorCode,
    String? responseDesc,
  }) : super(
          mrngOpeningtime: mrngOpeningtime,
          mrngClosingTime: mrngClosingTime,
          evngOpeningTime: evngOpeningTime,
          evngClosingTime: evngClosingTime,
          remarks: remarks,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory TempleTiming.fromJson(String str) =>
      TempleTiming.fromMap(json.decode(str));

  factory TempleTiming.fromMap(Map<String, dynamic> json) => TempleTiming(
        mrngOpeningtime: json["mrng_openingtime"],
        mrngClosingTime: json["mrng_closing_time"],
        evngOpeningTime: json["evng_opening_time"],
        evngClosingTime: json["evng_closing_time"],
        remarks: json["remarks"],
        errorCode: json["error_code"],
        responseDesc: json["response_desc"],
      );
}
