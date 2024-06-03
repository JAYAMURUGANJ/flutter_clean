import 'dart:convert';

import 'package:news_app_clean_architecture/features/temple_details/domain/entities/shrines_details.dart';

class ShrinesDetails extends ShrinesDetailsEntity {
  const ShrinesDetails({
    final String? subshrineName,
    final String? subshrineDesc,
    final String? specialityDesc,
    final String? statusDesc,
    final List<SubshrineImage>? subshrineImage,
    String? errorCode,
    String? responseDesc,
  }) : super(
          subshrineName: subshrineName,
          subshrineDesc: subshrineDesc,
          specialityDesc: specialityDesc,
          statusDesc: statusDesc,
          subshrineImage: subshrineImage,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory ShrinesDetails.fromJson(String str) =>
      ShrinesDetails.fromJson(json.decode(str));

  factory ShrinesDetails.fromMap(Map<String, dynamic> json) => ShrinesDetails(
        subshrineName: json["subshrine_name"],
        subshrineDesc: json["subshrine_desc"],
        specialityDesc: json["speciality_desc"],
        statusDesc: json["status_desc"],
        subshrineImage: json["subshrine_image"] == null
            ? []
            : List<SubshrineImage>.from(json["subshrine_image"]!
                .map((x) => SubshrineImage.fromJson(x))),
        errorCode: json["error_code"] ?? "",
        responseDesc: json["response_desc"] ?? "",
      );
}
