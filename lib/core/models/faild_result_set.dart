import 'package:json_annotation/json_annotation.dart';

part 'faild_result_set.g.dart';

@JsonSerializable()
class ResponceStatus {
  @JsonKey(name: 'error_code')
  dynamic errorCode;
  @JsonKey(name: 'response_desc')
  String? responseDesc;


  ResponceStatus({this.errorCode, this.responseDesc});

  factory ResponceStatus.fromJson(Map<String, dynamic> json) =>
      _$ResponceStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ResponceStatusToJson(this);
}
