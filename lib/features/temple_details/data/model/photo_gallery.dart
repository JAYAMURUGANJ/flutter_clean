import 'dart:convert';

import 'package:news_app_clean_architecture/features/temple_details/domain/entities/photo_gallery.dart';

class PhotoGallery extends PhotoGalleryEntity {
  const PhotoGallery({
    final DateTime? eventDate,
    final String? title,
    final String? description,
    final String? galleryDesc,
    final List<PhotoInfo>? photoInfo,
    String? errorCode,
    String? responseDesc,
  }) : super(
          eventDate: eventDate,
          title: title,
          description: description,
          galleryDesc: galleryDesc,
          photoInfo: photoInfo,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory PhotoGallery.fromJson(String str) =>
      PhotoGallery.fromMap(json.decode(str));

  factory PhotoGallery.fromMap(Map<String, dynamic> json) => PhotoGallery(
        eventDate: json["event_date"] == null
            ? null
            : DateTime.parse(json["event_date"]),
        title: json["title"],
        description: json["description"],
        galleryDesc: json["gallery_desc"],
        photoInfo: json["photo_info"] == null
            ? []
            : List<PhotoInfo>.from(
                json["photo_info"]!.map((x) => PhotoInfo.fromJson(x))),
        errorCode: json["error_code"] ?? "",
        responseDesc: json["response_desc"] ?? "",
      );
}
