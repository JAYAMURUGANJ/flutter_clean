// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'form_data.g.dart';

@JsonSerializable()
class ApiFormData {
  @JsonKey(name: 'form_data')
  final String formData;

  ApiFormData({
    required this.formData,
  });

  factory ApiFormData.fromJson(Map<String, dynamic> json) =>
      _$ApiFormDataFromJson(json);

  Map<String, dynamic> toJson() => _$ApiFormDataToJson(this);
}
