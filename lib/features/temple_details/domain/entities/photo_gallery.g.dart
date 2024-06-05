// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_gallery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoGalleryEntity _$PhotoGalleryEntityFromJson(Map<String, dynamic> json) =>
    PhotoGalleryEntity(
      eventDate: json['event_date'] == null
          ? null
          : DateTime.parse(json['event_date'] as String),
      title: json['title'] as String?,
      description: json['description'] as String?,
      galleryDesc: json['gallery_desc'] as String?,
      photoInfo: (json['photo_info'] as List<dynamic>?)
          ?.map((e) => PhotoInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['error_code'] as String?,
      responseDesc: json['response_desc'] as String?,
    );

Map<String, dynamic> _$PhotoGalleryEntityToJson(PhotoGalleryEntity instance) =>
    <String, dynamic>{
      'event_date': instance.eventDate?.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
      'gallery_desc': instance.galleryDesc,
      'photo_info': instance.photoInfo,
      'error_code': instance.errorCode,
      'response_desc': instance.responseDesc,
    };

PhotoInfo _$PhotoInfoFromJson(Map<String, dynamic> json) => PhotoInfo(
      fileLocation: json['file_location'] as String?,
    );

Map<String, dynamic> _$PhotoInfoToJson(PhotoInfo instance) => <String, dynamic>{
      'file_location': instance.fileLocation,
    };
