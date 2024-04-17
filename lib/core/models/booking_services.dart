import 'package:flutter/material.dart';

class TempleServices {
  int id;
  String? name;
  String? tName;
  String? imageLink;
  Color? bgColor;
  bool value;
  String? page;

  TempleServices(
      {required this.id,
      required this.name,
      required this.imageLink,
      required this.bgColor,
      this.value = false,
      this.page});

  factory TempleServices.fromJson(Map<String, dynamic> jsonData) {
    return TempleServices(
        id: jsonData['id'],
        name: jsonData['name'],
        imageLink: jsonData['imageLink'],
        bgColor: jsonData['bg_color'],
        value: jsonData['value'],
        page: jsonData['page']);
  }

  static Map<String, dynamic> toMap(TempleServices bookingServices) => {
        'id': bookingServices.id,
        'name': bookingServices.name,
        'imageLink': bookingServices.imageLink,
        'bg_color': bookingServices.bgColor,
        'value': bookingServices.value,
        'page': bookingServices.page,
      };
}
