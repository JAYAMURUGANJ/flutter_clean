class God {
  int id;
  String? name;
  String? tName;
  String? imageLink;
  bool value;

  God(
      {required this.id,
      required this.name,
      required this.tName,
      required this.imageLink,
      this.value = false});

  factory God.fromJson(Map<String, dynamic> jsonData) {
    return God(
      id: jsonData['id'],
      name: jsonData['name'],
      tName: jsonData['t_name'],
      imageLink: jsonData['imageLink'],
      value: jsonData['value'],
    );
  }

  static Map<String, dynamic> toMap(God music) => {
        'id': music.id,
        'name': music.name,
        't_name': music.tName,
        'imageLink': music.imageLink,
        'value': music.value,
      };
}
