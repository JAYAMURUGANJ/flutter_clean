// To parse this JSON data, do
//
//     final calendarEvent = calendarEventFromMap(jsonString);

import 'dart:convert';

import '../../domain/entities/calendar_event.dart';

List<CalendarEvent> calendarEventFromList(List list) =>
    list.map((e) => CalendarEvent.fromMap(e)).toList();

class CalendarEvent extends CalendarEventEntity {
  const CalendarEvent({
    final DateTime? calendarDays,
    final List<FestivalDatum>? festivalData,
    String? errorCode,
    String? responseDesc,
  }) : super(
          calendarDays: calendarDays,
          festivalData: festivalData,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory CalendarEvent.fromJson(String str) =>
      CalendarEvent.fromMap(json.decode(str));

  factory CalendarEvent.fromMap(Map<String, dynamic> json) => CalendarEvent(
        calendarDays: json["calendar_days"] == null
            ? null
            : DateTime.parse(json["calendar_days"]),
        festivalData: json["festival_data"] == null
            ? []
            : List<FestivalDatum>.from(
                json["festival_data"]!.map((x) => FestivalDatum.fromJson(x))),
        errorCode: json["error_code"] ?? "",
        responseDesc: json["response_desc"] ?? "",
      );
}
