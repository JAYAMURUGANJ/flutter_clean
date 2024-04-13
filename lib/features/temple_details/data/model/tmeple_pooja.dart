import 'dart:convert';

import 'package:news_app_clean_architecture/features/temple_details/domain/entities/temple_pooja.dart';

class TemplePooja extends TemplePoojaEntity {
  const TemplePooja({
    String? poojaDesc,
    String? alangaram,
    String? poojaTime,
  }) : super(
          poojaDesc: poojaDesc,
          alangaram: alangaram,
          poojaTime: poojaTime,
        );

  factory TemplePooja.fromJson(String str) =>
      TemplePooja.fromMap(json.decode(str));

  factory TemplePooja.fromMap(Map<String, dynamic> json) => TemplePooja(
        poojaDesc: json["pooja_desc"],
        alangaram: json["alangaram"],
        poojaTime: json["pooja_time"],
      );
}
