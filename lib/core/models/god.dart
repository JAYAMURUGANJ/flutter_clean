import 'dart:ui';

class God {
  int id;
  String? name;
  String? tName;
  String? imageLink;
  bool value;
  Color? bgColor;

  God(
      {required this.id,
      required this.name,
      required this.tName,
      required this.imageLink,
      required this.bgColor,
      this.value = false});

  factory God.fromJson(Map<String, dynamic> jsonData) {
    return God(
      id: jsonData['id'],
      name: jsonData['name'],
      tName: jsonData['t_name'],
      imageLink: jsonData['imageLink'],
      bgColor: jsonData['bg_color'],
      value: jsonData['value'],
    );
  }

  static Map<String, dynamic> toMap(God god) => {
        'id': god.id,
        'name': god.name,
        't_name': god.tName,
        'imageLink': god.imageLink,
        'bg_color': god.bgColor,
        'value': god.value,
      };
}
