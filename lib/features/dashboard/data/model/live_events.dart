// To parse this JSON data, do
//
//     final liveEvents = liveEventsFromMap(jsonString);

import 'dart:convert';

import '/features/dashboard/domain/entities/live_events.dart';

class LiveEvents extends LiveEventsEntity {
  const LiveEvents({
    final String? templeid,
    final int? templeId,
    final String? templeName,
    final String? ttempleName,
    final List<MaintowerImage>? maintowerImage,
    final List<ScrollDatum>? scrollData,
    String? errorCode,
    String? responseDesc,
  }) : super(
          templeid: templeid,
          templeId: templeId,
          templeName: templeName,
          ttempleName: ttempleName,
          maintowerImage: maintowerImage,
          scrollData: scrollData,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );
  factory LiveEvents.fromJson(String str) =>
      LiveEvents.fromMap(json.decode(str));

  factory LiveEvents.fromMap(Map<String, dynamic> json) => LiveEvents(
        templeid: json["templeid"],
        templeId: json["temple_id"],
        templeName: json["temple_name"],
        ttempleName: json["ttemple_name"],
        maintowerImage: json["maintower_image"] == null
            ? []
            : List<MaintowerImage>.from(json["maintower_image"]!
                .map((x) => MaintowerImage.fromJson(x))),
        scrollData: json["scroll_data"] == null
            ? []
            : List<ScrollDatum>.from(
                json["scroll_data"]!.map((x) => ScrollDatum.fromJson(x))),
        errorCode: json["error_code"] ?? "",
        responseDesc: json["response_desc"] ?? "",
      );
}
