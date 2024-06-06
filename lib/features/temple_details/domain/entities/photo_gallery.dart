import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_gallery.g.dart';

@JsonSerializable()
class PhotoGalleryEntity extends Equatable {
  @JsonKey(name: "event_date")
  final DateTime? eventDate;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "gallery_desc")
  final String? galleryDesc;
  @JsonKey(name: "photo_info")
  final List<PhotoInfo>? photoInfo;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const PhotoGalleryEntity({
    this.eventDate,
    this.title,
    this.description,
    this.galleryDesc,
    this.photoInfo,
    this.errorCode,
    this.responseDesc,
  });

  factory PhotoGalleryEntity.fromJson(Map<String, dynamic> json) =>
      _$PhotoGalleryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoGalleryEntityToJson(this);

  @override
  List<Object?> get props {
    return [
      eventDate,
      title,
      description,
      galleryDesc,
      photoInfo,
      errorCode,
      responseDesc,
      errorCode,
      responseDesc,
    ];
  }
}

@JsonSerializable()
class PhotoInfo {
  @JsonKey(name: "file_location")
  final String? fileLocation;

  PhotoInfo({
    this.fileLocation,
  });

  factory PhotoInfo.fromJson(Map<String, dynamic> json) =>
      _$PhotoInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoInfoToJson(this);
}
