// ignore_for_file: must_be_immutable

import 'dart:convert';

import '../../domain/entities/temple_info.dart';


class TempleInfo extends TempleInfoEntity {
  String? description;
  String? moolavarSwamiName;
  String? moolavarAmbalName;
  dynamic aagamamDesc;
  String? poetName;
  dynamic historicalName;
  String? sthalaVirutcham;
  String? templeTheertham;
  List<TempleImage>? templeImages;
  String? errorCode;
  String? responseDesc;

  TempleInfo({
    this.description,
    this.moolavarSwamiName,
    this.moolavarAmbalName,
    this.aagamamDesc,
    this.poetName,
    this.historicalName,
    this.sthalaVirutcham,
    this.templeTheertham,
    this.templeImages,
    this.errorCode,
    this.responseDesc,
  });

  factory TempleInfo.fromJson(String str) =>
      TempleInfo.fromMap(json.decode(str));

  factory TempleInfo.fromMap(Map<String, dynamic> json) => TempleInfo(
        description: json["description"],
        moolavarSwamiName: json["moolavar_swami_name"],
        moolavarAmbalName: json["moolavar_ambal_name"],
        aagamamDesc: json["aagamam_desc"],
        poetName: json["poet_name"],
        historicalName: json["historical_name"],
        sthalaVirutcham: json["sthala_virutcham"],
        templeTheertham: json["temple_theertham"],
        templeImages: json["temple_images"] == null
            ? []
            : List<TempleImage>.from(
                json["temple_images"]!.map((x) => TempleImage.fromJson(x))),
        errorCode: json["error_code"] ?? "",
        responseDesc: json["response_desc"] ?? "",
      );
}
