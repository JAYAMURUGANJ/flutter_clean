import 'dart:convert';

import 'package:news_app_clean_architecture/features/temple_details/domain/entities/temple_info.dart';

class TempleInfo extends TempleInfoEntity {
  const TempleInfo({
    String? description,
    String? moolavarSwamiName,
    String? moolavarAmbalName,
    dynamic aagamamDesc,
    String? poetName,
    dynamic historicalName,
    String? sthalaVirutcham,
    String? templeTheertham,
    List<TempleImage>? templeImages,
    String? errorCode,
    String? responseDesc,
  }) : super(
          description: description,
          moolavarSwamiName: moolavarSwamiName,
          moolavarAmbalName: moolavarAmbalName,
          aagamamDesc: aagamamDesc,
          poetName: poetName,
          historicalName: historicalName,
          sthalaVirutcham: sthalaVirutcham,
          templeTheertham: templeTheertham,
          templeImages: templeImages,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

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
