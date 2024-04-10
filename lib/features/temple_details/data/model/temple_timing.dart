import 'dart:convert';

import 'package:news_app_clean_architecture/features/temple_details/domain/entities/temple_timing.dart';

class TempleTiming extends TempleTimingEntity {
  const TempleTiming({
    String? mrngOpeningtime,
    String? mrngClosingTime,
    String? evngOpeningTime,
    String? evngClosingTime,
    String? remarks,
    // List<ClosingTime>? closingTime,
  }) : super(
          mrngOpeningtime: mrngOpeningtime,
          mrngClosingTime: mrngClosingTime,
          evngOpeningTime: evngOpeningTime,
          evngClosingTime: evngClosingTime,
          remarks: remarks,
          // closingTime: closingTime,
        );

  factory TempleTiming.fromJson(String str) =>
      TempleTiming.fromMap(json.decode(str));

  factory TempleTiming.fromMap(Map<String, dynamic> json) => TempleTiming(
        mrngOpeningtime: json["mrng_openingtime"],
        mrngClosingTime: json["mrng_closing_time"],
        evngOpeningTime: json["evng_opening_time"],
        evngClosingTime: json["evng_closing_time"],
        remarks: json["remarks"],
        // closingTime: json["closing_time"] == null
        //     ? []
        //     : List<ClosingTime>.from(
        //         json["closing_time"]!.map((x) => ClosingTime.fromJson(x))),
      );
}
