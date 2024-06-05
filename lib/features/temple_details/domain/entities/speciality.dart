import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'speciality.g.dart';

@JsonSerializable()
class SpecialityEntity extends Equatable {
  @JsonKey(name: "speciality_desc")
  final String? specialityDesc;
  @JsonKey(name: "speciality_details")
  final String? specialityDetails;
  @JsonKey(name: "speciality_title")
  final String? specialityTitle;
  @JsonKey(name: "speciality_image")
  final List<SpecialityImage>? specialityImage;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const SpecialityEntity({
    this.specialityDesc,
    this.specialityDetails,
    this.specialityTitle,
    this.specialityImage,
    this.errorCode,
    this.responseDesc,
  });

  factory SpecialityEntity.fromJson(Map<String, dynamic> json) =>
      _$SpecialityEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialityEntityToJson(this);
  @override
  List<Object?> get props {
    return [
      specialityDesc,
      specialityDetails,
      specialityTitle,
      specialityImage,
      errorCode,
      responseDesc,
    ];
  }
}

@JsonSerializable()
class SpecialityImage {
  @JsonKey(name: "file_location")
  final String? fileLocation;

  SpecialityImage({
    this.fileLocation,
  });

  factory SpecialityImage.fromJson(Map<String, dynamic> json) =>
      _$SpecialityImageFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialityImageToJson(this);
}
