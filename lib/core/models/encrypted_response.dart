import 'package:json_annotation/json_annotation.dart';

part 'encrypted_response.g.dart';

@JsonSerializable()
class EncryptedResponse {
  @JsonKey(name: 'result_set')
  dynamic resultSet;
  @JsonKey(name: 'response_status')
  String? responseStatus;
  EncryptedResponse({this.resultSet, this.responseStatus});

  factory EncryptedResponse.fromJson(Map<String, dynamic> json) =>
      _$EncryptedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EncryptedResponseToJson(this);
}
