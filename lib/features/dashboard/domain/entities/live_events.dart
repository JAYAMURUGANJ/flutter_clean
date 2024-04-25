// To parse this JSON data, do
//
//     final liveEventsEntity = liveEventsEntityFromMap(jsonString);

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'live_events.g.dart';

@JsonSerializable()
class LiveEventsEntity extends Equatable {
  @JsonKey(name: "templeid")
  final String? templeid;
  @JsonKey(name: "temple_id")
  final int? templeId;
  @JsonKey(name: "temple_name")
  final String? templeName;
  @JsonKey(name: "ttemple_name")
  final String? ttempleName;
  @JsonKey(name: "maintower_image")
  final List<MaintowerImage>? maintowerImage;
  @JsonKey(name: "scroll_data")
  final List<ScrollDatum>? scrollData;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const LiveEventsEntity({
    this.templeid,
    this.templeId,
    this.templeName,
    this.ttempleName,
    this.maintowerImage,
    this.scrollData,
    this.errorCode,
    this.responseDesc,
  });

  factory LiveEventsEntity.fromJson(Map<String, dynamic> json) =>
      _$LiveEventsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LiveEventsEntityToJson(this);
  @override
  List<Object?> get props {
    return [
      templeid,
      templeId,
      templeName,
      ttempleName,
      maintowerImage,
      scrollData,
      errorCode,
      responseDesc,
    ];
  }
}

@JsonSerializable()
class MaintowerImage {
  @JsonKey(name: "file_location")
  final String? fileLocation;

  MaintowerImage({
    this.fileLocation,
  });

  factory MaintowerImage.fromJson(Map<String, dynamic> json) =>
      _$MaintowerImageFromJson(json);

  Map<String, dynamic> toJson() => _$MaintowerImageToJson(this);
}

@JsonSerializable()
class ScrollDatum extends Equatable {
  @JsonKey(name: "event_desc")
  final String? eventDesc;
  @JsonKey(name: "from_date")
  final DateTime? fromDate;
  @JsonKey(name: "to_date")
  final DateTime? toDate;
  @JsonKey(name: "file_info")
  final List<dynamic>? fileInfo;
  @JsonKey(name: "event_url")
  final String? eventUrl;
  @JsonKey(name: "content_type")
  final String? contentType;
  @JsonKey(name: "liveurl")
  final String? liveurl;
  @JsonKey(name: "liveurl_type")
  final String? liveurlType;
  @JsonKey(name: "telecast_timing")
  final List<TelecastTiming>? telecastTiming;
  @JsonKey(name: "function_date")
  final String? functionDate;
  @JsonKey(name: "published_from")
  final DateTime? publishedFrom;
  @JsonKey(name: "published_upto")
  final DateTime? publishedUpto;

  const ScrollDatum({
    this.eventDesc,
    this.fromDate,
    this.toDate,
    this.fileInfo,
    this.eventUrl,
    this.contentType,
    this.liveurl,
    this.liveurlType,
    this.telecastTiming,
    this.functionDate,
    this.publishedFrom,
    this.publishedUpto,
  });

  factory ScrollDatum.fromJson(Map<String, dynamic> json) =>
      _$ScrollDatumFromJson(json);

  Map<String, dynamic> toJson() => _$ScrollDatumToJson(this);
  @override
  List<Object?> get props {
    return [
      eventDesc,
      fromDate,
      toDate,
      fileInfo,
      eventUrl,
      contentType,
      liveurl,
      liveurlType,
      telecastTiming,
      functionDate,
      publishedFrom,
      publishedUpto,
    ];
  }
}

@JsonSerializable()
class TelecastTiming extends Equatable {
  @JsonKey(name: "to_time")
  final String? toTime;
  @JsonKey(name: "from_time")
  final String? fromTime;

  const TelecastTiming({
    this.toTime,
    this.fromTime,
  });

  factory TelecastTiming.fromJson(Map<String, dynamic> json) =>
      _$TelecastTimingFromJson(json);

  Map<String, dynamic> toJson() => _$TelecastTimingToJson(this);

  @override
  List<Object?> get props {
    return [
      toTime,
      fromTime,
    ];
  }
}
