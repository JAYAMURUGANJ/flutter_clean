import 'dart:convert';

import '/features/temple_details/domain/entities/contact_details.dart';

class ContactDetails extends ContactDetailsEntity {
  const ContactDetails({
    String? templeName,
    String? templeDoorno,
    String? templeStreet,
    String? templeLocation,
    String? pincode,
    String? landline,
    String? email,
    String? districtName,
    String? username,
    String? designationDesc,
    String? prefixDesc,
    String? errorCode,
    String? responseDesc,
  }) : super(
          templeName: templeName,
          templeDoorno: templeDoorno,
          templeStreet: templeStreet,
          templeLocation: templeLocation,
          pincode: pincode,
          landline: landline,
          email: email,
          districtName: districtName,
          username: username,
          designationDesc: designationDesc,
          prefixDesc: prefixDesc,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory ContactDetails.fromJson(String str) =>
      ContactDetails.fromMap(json.decode(str));

  factory ContactDetails.fromMap(Map<String, dynamic> json) => ContactDetails(
        templeName: json["temple_name"],
        templeDoorno: json["temple_doorno"],
        templeStreet: json["temple_street"],
        templeLocation: json["temple_location"],
        pincode: json["pincode"],
        landline: json["landline"],
        email: json["email"],
        districtName: json["district_name"],
        username: json["username"],
        designationDesc: json["designation_desc"],
        prefixDesc: json["prefix_desc"],
        errorCode: json["error_code"] ?? "",
        responseDesc: json["response_desc"] ?? "",
      );
}
