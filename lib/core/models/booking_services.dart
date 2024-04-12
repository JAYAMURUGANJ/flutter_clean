import 'package:flutter/material.dart';

class BookingServices {
  int id;
  String? name;
  String? tName;
  String? imageLink;
  String? emoji;
  Color? bgColor;
  bool value;
  String? page;

  BookingServices(
      {required this.id,
      required this.name,
      required this.tName,
      required this.imageLink,
      required this.emoji,
      required this.bgColor,
      this.value = false,
      this.page});

  factory BookingServices.fromJson(Map<String, dynamic> jsonData) {
    return BookingServices(
        id: jsonData['id'],
        name: jsonData['name'],
        tName: jsonData['t_name'],
        imageLink: jsonData['imageLink'],
        emoji: jsonData['emoji'],
        bgColor: jsonData['bg_color'],
        value: jsonData['value'],
        page: jsonData['page']);
  }

  static Map<String, dynamic> toMap(BookingServices bookingServices) => {
        'id': bookingServices.id,
        'name': bookingServices.name,
        't_name': bookingServices.tName,
        'imageLink': bookingServices.imageLink,
        'emoji': bookingServices.emoji,
        'bg_color': bookingServices.bgColor,
        'value': bookingServices.value,
        'page': bookingServices.page,
      };
}
