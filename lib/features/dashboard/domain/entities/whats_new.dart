import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'whats_new.g.dart';

@JsonSerializable()
class WhatsNewEntity extends Equatable {
  @JsonKey(name: "dated")
  final String? dated;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "whatsnew_images")
  final List<WhatsnewImage>? whatsnewImages;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const WhatsNewEntity({
    this.dated,
    this.title,
    this.description,
    this.whatsnewImages,
    this.errorCode,
    this.responseDesc,
  });

  factory WhatsNewEntity.fromJson(Map<String, dynamic> json) =>
      _$WhatsNewEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WhatsNewEntityToJson(this);
  
  @override
  List<Object?> get props {
    return [
      dated,
      title,
      description,
      whatsnewImages,
      errorCode,
      responseDesc,
    ];
  }
}

@JsonSerializable()
class WhatsnewImage {
  @JsonKey(name: "file_location")
  String? fileLocation;

  WhatsnewImage({
    this.fileLocation,
  });

  factory WhatsnewImage.fromJson(Map<String, dynamic> json) =>
      _$WhatsnewImageFromJson(json);

  Map<String, dynamic> toJson() => _$WhatsnewImageToJson(this);
}
