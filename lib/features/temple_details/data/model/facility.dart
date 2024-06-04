import 'dart:convert';

import 'package:news_app_clean_architecture/features/temple_details/domain/entities/facility.dart';

class Facility extends FacilityEntity {
  const Facility({
    final String? templeid,
    final int? templeId,
    final String? templeName,
    final String? ttempleName,
    final String? facilityTitle,
    final String? facilityLocation,
    final String? facilityDesc,
    final String? noofFacilities,
    final List<Image>? facilityImage,
    final String? contactPerson,
    final String? contactNo,
    final List<Image>? maintowerImage,
    String? errorCode,
    String? responseDesc,
  }) : super(
          templeid: templeid,
          templeId: templeId,
          templeName: templeName,
          ttempleName: ttempleName,
          facilityTitle: facilityTitle,
          facilityLocation: facilityLocation,
          facilityDesc: facilityDesc,
          noofFacilities: noofFacilities,
          facilityImage: facilityImage,
          contactPerson: contactPerson,
          contactNo: contactNo,
          maintowerImage: maintowerImage,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory Facility.fromJson(String str) => Facility.fromMap(json.decode(str));

  factory Facility.fromMap(Map<String, dynamic> json) => Facility(
        templeid: json["templeid"],
        templeId: json["temple_id"],
        templeName: json["temple_name"],
        ttempleName: json["ttemple_name"],
        facilityTitle: json["facility_title"],
        facilityLocation: json["facility_location"],
        facilityDesc: json["facility_desc"],
        noofFacilities: json["noof_facilities"],
        facilityImage: json["facility_image"] == null
            ? []
            : List<Image>.from(
                json["facility_image"]!.map((x) => Image.fromJson(x))),
        contactPerson: json["contact_person"],
        contactNo: json["contact_no"],
        maintowerImage: json["maintower_image"] == null
            ? []
            : List<Image>.from(
                json["maintower_image"]!.map((x) => Image.fromJson(x))),
      );
}
