import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'worship.g.dart';

@JsonSerializable()
class WorshipEntity extends Equatable {
  @JsonKey(name: "worship_code")
  final int? worshipCode;
  @JsonKey(name: "worship_desc")
  final String? worshipDesc;
  @JsonKey(name: "tworship_desc")
  final String? tworshipDesc;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const WorshipEntity({
    this.worshipCode,
    this.worshipDesc,
    this.tworshipDesc,
    this.errorCode,
    this.responseDesc,
  });

  factory WorshipEntity.fromJson(Map<String, dynamic> json) =>
      _$WorshipEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WorshipEntityToJson(this);

  @override
  List<Object?> get props => [
        worshipCode,
        worshipDesc,
        tworshipDesc,
        errorCode,
        responseDesc,
      ];
}
