import 'dart:convert';

import 'package:news_app_clean_architecture/features/temple_list/domain/entities/worship.dart';

class Worship extends WorshipEntity {
  const Worship({
    final int? worshipCode,
    final String? worshipDesc,
    final String? tworshipDesc,
    String? errorCode,
    String? responseDesc,
  }) : super(
          worshipCode: worshipCode,
          worshipDesc: worshipDesc,
          tworshipDesc: tworshipDesc,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory Worship.fromJson(String str) => Worship.fromMap(json.decode(str));

  factory Worship.fromMap(Map<String, dynamic> json) => Worship(
        worshipCode: json["worship_code"],
        worshipDesc: json["worship_desc"],
        tworshipDesc: json["tworship_desc"],
        errorCode: json["error_code"] ?? "",
        responseDesc: json["response_desc"] ?? "",
      );
}
