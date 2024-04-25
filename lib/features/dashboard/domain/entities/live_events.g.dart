// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveEventsEntity _$LiveEventsEntityFromJson(Map<String, dynamic> json) =>
    LiveEventsEntity(
      templeid: json['templeid'] as String?,
      templeId: json['temple_id'] as int?,
      templeName: json['temple_name'] as String?,
      ttempleName: json['ttemple_name'] as String?,
      maintowerImage: (json['maintower_image'] as List<dynamic>?)
          ?.map((e) => MaintowerImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      scrollData: (json['scroll_data'] as List<dynamic>?)
          ?.map((e) => ScrollDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LiveEventsEntityToJson(LiveEventsEntity instance) =>
    <String, dynamic>{
      'templeid': instance.templeid,
      'temple_id': instance.templeId,
      'temple_name': instance.templeName,
      'ttemple_name': instance.ttempleName,
      'maintower_image': instance.maintowerImage,
      'scroll_data': instance.scrollData,
    };

MaintowerImage _$MaintowerImageFromJson(Map<String, dynamic> json) =>
    MaintowerImage(
      fileLocation: json['file_location'] as String?,
    );

Map<String, dynamic> _$MaintowerImageToJson(MaintowerImage instance) =>
    <String, dynamic>{
      'file_location': instance.fileLocation,
    };

ScrollDatum _$ScrollDatumFromJson(Map<String, dynamic> json) => ScrollDatum(
      eventDesc: json['event_desc'] as String?,
      fromDate: json['from_date'] == null
          ? null
          : DateTime.parse(json['from_date'] as String),
      toDate: json['to_date'] == null
          ? null
          : DateTime.parse(json['to_date'] as String),
      fileInfo: json['file_info'] as List<dynamic>?,
      eventUrl: json['event_url'] as String?,
      contentType: json['content_type'] as String?,
      liveurl: json['liveurl'] as String?,
      liveurlType: json['liveurl_type'] as String?,
      telecastTiming: (json['telecast_timing'] as List<dynamic>?)
          ?.map((e) => TelecastTiming.fromJson(e as Map<String, dynamic>))
          .toList(),
      functionDate: json['function_date'] as String?,
      publishedFrom: json['published_from'] == null
          ? null
          : DateTime.parse(json['published_from'] as String),
      publishedUpto: json['published_upto'] == null
          ? null
          : DateTime.parse(json['published_upto'] as String),
    );

Map<String, dynamic> _$ScrollDatumToJson(ScrollDatum instance) =>
    <String, dynamic>{
      'event_desc': instance.eventDesc,
      'from_date': instance.fromDate?.toIso8601String(),
      'to_date': instance.toDate?.toIso8601String(),
      'file_info': instance.fileInfo,
      'event_url': instance.eventUrl,
      'content_type': instance.contentType,
      'liveurl': instance.liveurl,
      'liveurl_type': instance.liveurlType,
      'telecast_timing': instance.telecastTiming,
      'function_date': instance.functionDate,
      'published_from': instance.publishedFrom?.toIso8601String(),
      'published_upto': instance.publishedUpto?.toIso8601String(),
    };

TelecastTiming _$TelecastTimingFromJson(Map<String, dynamic> json) =>
    TelecastTiming(
      toTime: json['to_time'] as String?,
      fromTime: json['from_time'] as String?,
    );

Map<String, dynamic> _$TelecastTimingToJson(TelecastTiming instance) =>
    <String, dynamic>{
      'to_time': instance.toTime,
      'from_time': instance.fromTime,
    };
