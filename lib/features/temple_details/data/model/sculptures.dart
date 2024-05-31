import 'dart:convert';

import 'package:news_app_clean_architecture/features/temple_details/domain/entities/sculptures.dart';

class Sculptures extends SculpturesEntity {
  const Sculptures({
    String? sculpturesName,
    String? sculptureDesc,
    List<SculptureInfo>? sculptureInfo,
    String? errorCode,
    String? responseDesc,
  }) : super(
          sculpturesName: sculpturesName,
          sculptureDesc: sculptureDesc,
          sculptureInfo: sculptureInfo,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory Sculptures.fromJson(String str) =>
      Sculptures.fromMap(json.decode(str));

  factory Sculptures.fromMap(Map<String, dynamic> json) => Sculptures(
        sculpturesName: json["sculptures_name"],
        sculptureDesc: json["sculpture_desc"],
        sculptureInfo: json["sculpture_info"] == null
            ? []
            : List<SculptureInfo>.from(
                json["sculpture_info"]!.map((x) => SculptureInfo.fromJson(x))),
        errorCode: json["error_code"] ?? "",
        responseDesc: json["response_desc"] ?? "",
      );
}
