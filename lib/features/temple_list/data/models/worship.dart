import 'dart:convert';

import 'package:news_app_clean_architecture/features/temple_list/domain/entities/worship_god_list.dart';

class WorshipGod extends WorshipGodEntity {
  const WorshipGod({
    final int? worshipCode,
    final String? worshipDesc,
    final String? tworshipDesc,
    final List<ImgfileInfo>? imgfileInfo,
    String? errorCode,
    String? responseDesc,
  }) : super(
          worshipCode: worshipCode,
          worshipDesc: worshipDesc,
          tworshipDesc: tworshipDesc,
          imgfileInfo: imgfileInfo,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory WorshipGod.fromJson(String str) =>
      WorshipGod.fromMap(json.decode(str));

  factory WorshipGod.fromMap(Map<String, dynamic> json) => WorshipGod(
        worshipCode: json["worship_code"],
        worshipDesc: json["worship_desc"],
        tworshipDesc: json["tworship_desc"],
        imgfileInfo: (json['imgfile_info'] as List<dynamic>?)
            ?.map((e) => ImgfileInfo.fromJson(e as Map<String, dynamic>))
            .toList(),
        errorCode: json["error_code"] ?? "",
        responseDesc: json["response_desc"] ?? "",
      );
}
