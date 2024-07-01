import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shrines_details.g.dart';

@JsonSerializable()
class ShrinesDetailsEntity extends Equatable {
  @JsonKey(name: "subshrine_name")
  final String? subshrineName;
  @JsonKey(name: "subshrine_desc")
  final String? subshrineDesc;
  @JsonKey(name: "speciality_desc")
  final String? specialityDesc;
  @JsonKey(name: "status_desc")
  final String? statusDesc;
  @JsonKey(name: "subshrine_image")
  final List<SubshrineImage>? subshrineImage;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const ShrinesDetailsEntity({
    this.subshrineName,
    this.subshrineDesc,
    this.specialityDesc,
    this.statusDesc,
    this.subshrineImage,
    this.errorCode,
    this.responseDesc,
  });

  factory ShrinesDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$ShrinesDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ShrinesDetailsEntityToJson(this);
  @override
  List<Object?> get props {
    return [
      subshrineName,
      subshrineDesc,
      specialityDesc,
      statusDesc,
      subshrineImage,
      errorCode,
      responseDesc,
    ];
  }
}

@JsonSerializable()
class SubshrineImage {
  @JsonKey(name: "file_location")
  final String? fileLocation;

  SubshrineImage({
    this.fileLocation,
  });

  factory SubshrineImage.fromJson(Map<String, dynamic> json) =>
      _$SubshrineImageFromJson(json);

  Map<String, dynamic> toJson() => _$SubshrineImageToJson(this);
}
