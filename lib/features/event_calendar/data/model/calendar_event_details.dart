import 'dart:convert';

import 'package:news_app_clean_architecture/features/event_calendar/domain/entities/calendar_event_details.dart';

class CalendarEventDetails extends CalendarEventDetailsEntity {
  const CalendarEventDetails({
    final int? templeId,
    final String? templeName,
    final int? festivalId,
    final DateTime? festivalFrom,
    final DateTime? festivalTo,
    final String? festivalName,
    final dynamic nakshatraDesc,
    final dynamic thithiDesc,
    final dynamic typeDesc,
    final List<FestivalInfo>? festivalInfo,
    String? errorCode,
    String? responseDesc,
  }) : super(
          templeId: templeId,
          templeName: templeName,
          festivalId: festivalId,
          festivalFrom: festivalFrom,
          festivalTo: festivalTo,
          festivalName: festivalName,
          nakshatraDesc: nakshatraDesc,
          thithiDesc: thithiDesc,
          typeDesc: typeDesc,
          festivalInfo: festivalInfo,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory CalendarEventDetails.fromJson(String str) =>
      CalendarEventDetails.fromMap(json.decode(str));
  factory CalendarEventDetails.fromMap(Map<String, dynamic> json) =>
      CalendarEventDetails(
        templeId: json["temple_id"],
        templeName: json["temple_name"],
        festivalId: json["festival_id"],
        festivalFrom: json["festival_from"] == null
            ? null
            : DateTime.parse(json["festival_from"]),
        festivalTo: json["festival_to"] == null
            ? null
            : DateTime.parse(json["festival_to"]),
        festivalName: json["festival_name"],
        nakshatraDesc: json["nakshatra_desc"],
        thithiDesc: json["thithi_desc"],
        typeDesc: json["type_desc"],
        festivalInfo: json["festival_info"] == null
            ? []
            : List<FestivalInfo>.from(
                json["festival_info"]!.map((x) => FestivalInfo.fromJson(x))),
        errorCode: json["error_code"] ?? "",
        responseDesc: json["response_desc"] ?? "",
      );
}
