import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_details.g.dart';

@JsonSerializable()
class ContactDetailsEntity extends Equatable {
  @JsonKey(name: "temple_name")
  final String? templeName;
  @JsonKey(name: "temple_doorno")
  final String? templeDoorno;
  @JsonKey(name: "temple_street")
  final String? templeStreet;
  @JsonKey(name: "temple_location")
  final String? templeLocation;
  @JsonKey(name: "pincode")
  final String? pincode;
  @JsonKey(name: "landline")
  final String? landline;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "district_name")
  final String? districtName;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "designation_desc")
  final String? designationDesc;
  @JsonKey(name: "prefix_desc")
  final String? prefixDesc;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const ContactDetailsEntity({
    this.templeName,
    this.templeDoorno,
    this.templeStreet,
    this.templeLocation,
    this.pincode,
    this.landline,
    this.email,
    this.districtName,
    this.username,
    this.designationDesc,
    this.prefixDesc,
    this.errorCode,
    this.responseDesc,
  });

  factory ContactDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDetailsEntityToJson(this);
  @override
  List<Object?> get props {
    return [
      templeName,
      templeDoorno,
      templeStreet,
      templeLocation,
      pincode,
      landline,
      email,
      districtName,
      username,
      designationDesc,
      prefixDesc,
      errorCode,
      responseDesc,
    ];
  }
}
