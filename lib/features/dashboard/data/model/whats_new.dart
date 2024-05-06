// To parse this JSON data, do
//
//     final whatsNew = whatsNewFromMap(jsonString);

import 'dart:convert';

import '/features/dashboard/domain/entities/whats_new.dart';

class WhatsNew extends WhatsNewEntity {
  const WhatsNew({
    String? dated,
    String? title,
    String? description,
    List<WhatsnewImage>? whatsnewImages,
    String? errorCode,
    String? responseDesc,
  }) : super(
          dated: dated,
          title: title,
          description: description,
          whatsnewImages: whatsnewImages,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );
  factory WhatsNew.fromJson(String str) => WhatsNew.fromMap(json.decode(str));
 
  factory WhatsNew.fromMap(Map<String, dynamic> json) => WhatsNew(
        dated: json["dated"],
        title: json["title"],
        description: json["description"],
        whatsnewImages: json["whatsnew_images"] == null
            ? []
            : List<WhatsnewImage>.from(
                json["whatsnew_images"]!.map((x) => WhatsnewImage.fromJson(x))),
        errorCode: json["error_code"] ?? "",
        responseDesc: json["response_desc"] ?? "",
      );
}
