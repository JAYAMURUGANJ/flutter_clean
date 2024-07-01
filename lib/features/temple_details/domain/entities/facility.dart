import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'facility.g.dart';

@JsonSerializable()
class FacilityEntity extends Equatable {
  @JsonKey(name: "templeid")
  final String? templeid;
  @JsonKey(name: "temple_id")
  final int? templeId;
  @JsonKey(name: "temple_name")
  final String? templeName;
  @JsonKey(name: "ttemple_name")
  final String? ttempleName;
  @JsonKey(name: "facility_title")
  final String? facilityTitle;
  @JsonKey(name: "facility_location")
  final String? facilityLocation;
  @JsonKey(name: "facility_desc")
  final String? facilityDesc;
  @JsonKey(name: "noof_facilities")
  final String? noofFacilities;
  @JsonKey(name: "facility_image")
  final List<Image>? facilityImage;
  @JsonKey(name: "contact_person")
  final String? contactPerson;
  @JsonKey(name: "contact_no")
  final String? contactNo;
  @JsonKey(name: "maintower_image")
  final List<Image>? maintowerImage;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const FacilityEntity({
    this.templeid,
    this.templeId,
    this.templeName,
    this.ttempleName,
    this.facilityTitle,
    this.facilityLocation,
    this.facilityDesc,
    this.noofFacilities,
    this.facilityImage,
    this.contactPerson,
    this.contactNo,
    this.maintowerImage,
    this.errorCode,
    this.responseDesc,
  });

  factory FacilityEntity.fromJson(Map<String, dynamic> json) =>
      _$FacilityEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FacilityEntityToJson(this);

  @override
  List<Object?> get props {
    return [
      templeid,
      templeId,
      templeName,
      ttempleName,
      facilityTitle,
      facilityLocation,
      facilityDesc,
      noofFacilities,
      facilityImage,
      contactPerson,
      contactNo,
      maintowerImage,
      errorCode,
      responseDesc,
      errorCode,
      responseDesc,
    ];
  }
}

@JsonSerializable()
class Image {
  @JsonKey(name: "file_location")
  final String? fileLocation;

  Image({
    this.fileLocation,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
