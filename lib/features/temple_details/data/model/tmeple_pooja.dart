import 'dart:convert';

import '/features/temple_details/domain/entities/temple_pooja.dart';

class TemplePooja extends TemplePoojaEntity {
  const TemplePooja({
    String? poojaDesc,
    String? alangaram,
    String? poojaTime,
    String? errorCode,
    String? responseDesc,
  }) : super(
          poojaDesc: poojaDesc,
          alangaram: alangaram,
          poojaTime: poojaTime,
          errorCode: errorCode,
          responseDesc: responseDesc,
        );

  factory TemplePooja.fromJson(String str) =>
      TemplePooja.fromMap(json.decode(str));

  factory TemplePooja.fromMap(Map<String, dynamic> json) => TemplePooja(
        poojaDesc: json["pooja_desc"],
        alangaram: json["alangaram"],
        poojaTime: json["pooja_time"],
        errorCode: json["error_code"],
        responseDesc: json["response_desc"],
      );
}
