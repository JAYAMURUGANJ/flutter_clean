import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'temple_list_response.g.dart';

@JsonSerializable()
class ItmsResponseEntity extends Equatable {
  @JsonKey(name: 'temple_Id')
  final int? templeId;
  @JsonKey(name: 'temple_name')
  final String? templeName;
  @JsonKey(name: 'ttemple_name')
  final String? ttempleName;
  @JsonKey(name: 'juris_office_code')
  final int? jurisOfficeCode;
  @JsonKey(name: 'district_code')
  final String? districtCode;
  @JsonKey(name: 'taluk_code')
  final String? talukCode;
  @JsonKey(name: 'village_code')
  final String? villageCode;
  @JsonKey(name: 'temple_typecode')
  final int? templeTypecode;
  @JsonKey(name: 'institute_categorycode')
  final int? instituteCategorycode;
  @JsonKey(name: 'templesection_code')
  final int? templesectionCode;
  @JsonKey(name: 'management_typecode')
  final int? managementTypecode;
  @JsonKey(name: 'management_subtype_code')
  final int? managementSubtypecode;
  @JsonKey(name: 'worship_code')
  final int? worshipCode;
  @JsonKey(name: 'url_templewebsite')
  final String? urlTemplewebsite;
  @JsonKey(name: 'postal_avail')
  final String? postalAvail;
  @JsonKey(name: 'annadhanam_enabled')
  final String? annadhanamEnabled;
  @JsonKey(name: 'degree360_avail')
  final String? degree360Avail;
  @JsonKey(name: 'degree_360view')
  final String? degree360view;
  @JsonKey(name: 'temple_latitude')
  final String? templeLatitude;
  @JsonKey(name: 'temple_langitude')
  final String? templeLangitude;
  @JsonKey(name: 'maintower_image')
  final List<MaintowerImage>? maintowerImage;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const ItmsResponseEntity({
    this.templeId,
    this.templeName,
    this.ttempleName,
    this.jurisOfficeCode,
    this.districtCode,
    this.talukCode,
    this.villageCode,
    this.templeTypecode,
    this.instituteCategorycode,
    this.templesectionCode,
    this.managementTypecode,
    this.managementSubtypecode,
    this.worshipCode,
    this.urlTemplewebsite,
    this.postalAvail,
    this.annadhanamEnabled,
    this.degree360Avail,
    this.degree360view,
    this.templeLatitude,
    this.templeLangitude,
    this.maintowerImage,
    this.errorCode,
    this.responseDesc,
  });

  factory ItmsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ItmsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ItmsResponseEntityToJson(this);

  @override
  List<Object?> get props {
    return [
      templeId,
      templeName,
      ttempleName,
      jurisOfficeCode,
      districtCode,
      talukCode,
      villageCode,
      templeTypecode,
      instituteCategorycode,
      templesectionCode,
      managementTypecode,
      managementSubtypecode,
      worshipCode,
      urlTemplewebsite,
      postalAvail,
      annadhanamEnabled,
      degree360Avail,
      degree360view,
      templeLatitude,
      templeLangitude,
      maintowerImage,
      errorCode,
      responseDesc,
    ];
  }
}

@JsonSerializable()
class MaintowerImage extends Equatable {
  @JsonKey(name: 'file_location')
  final String? fileLocation;

  const MaintowerImage({this.fileLocation});

  factory MaintowerImage.fromJson(Map<String, dynamic> json) =>
      _$MaintowerImageFromJson(json);

  Map<String, dynamic> toJson() => _$MaintowerImageToJson(this);

  @override
  List<Object?> get props => [fileLocation];
}
