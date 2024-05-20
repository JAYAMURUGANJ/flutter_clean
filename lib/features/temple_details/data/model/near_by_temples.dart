import 'dart:convert';
import '../../domain/entities/near_by_temples.dart';

class NearByTemples extends NearByTemplesEntity {
  const NearByTemples({
    final String? locationDesc,
    final String? locationFrom,
    final String? distance,
    final List<dynamic>? blueprintImage,
    final String? longitude,
    final String? latitude,
    String? errorCode,
    String? responseDesc,
  }) : super(
          locationDesc: locationDesc,
          locationFrom: locationFrom,
          distance: distance,
          blueprintImage: blueprintImage,
          longitude: longitude,
          latitude: latitude,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory NearByTemples.fromJson(String str) =>
      NearByTemples.fromMap(json.decode(str));

  factory NearByTemples.fromMap(Map<String, dynamic> json) => NearByTemples(
        locationDesc: json["location_desc"],
        locationFrom: json["location_from"],
        distance: json["distance"],
        blueprintImage: json["blueprint_image"] == null
            ? []
            : List<dynamic>.from(json["blueprint_image"]!.map((x) => x)),
        longitude: json["longitude"],
        latitude: json["latitude"],
        errorCode: json["error_code"] ?? "",
        responseDesc: json["response_desc"] ?? "",
      );
}
