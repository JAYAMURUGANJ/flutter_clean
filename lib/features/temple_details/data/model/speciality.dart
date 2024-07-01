import 'dart:convert';

import 'package:news_app_clean_architecture/features/temple_details/domain/entities/speciality.dart';

class Speciality extends SpecialityEntity {
  const Speciality({
    final String? specialityDesc,
    final String? specialityDetails,
    final String? specialityTitle,
    final List<SpecialityImage>? specialityImage,
    String? errorCode,
    String? responseDesc,
  }) : super(
          specialityDesc: specialityDesc,
          specialityDetails: specialityDetails,
          specialityTitle: specialityTitle,
          specialityImage: specialityImage,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory Speciality.fromJson(String str) =>
      Speciality.fromMap(json.decode(str));

  factory Speciality.fromMap(Map<String, dynamic> json) => Speciality(
        specialityDesc: json["speciality_desc"],
        specialityDetails: json["speciality_details"],
        specialityTitle: json["speciality_title"],
        specialityImage: json["speciality_image"] == null
            ? []
            : List<SpecialityImage>.from(json["speciality_image"]!
                .map((x) => SpecialityImage.fromJson(x))),
      );
}
