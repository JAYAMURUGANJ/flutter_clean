import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'temple_pooja.g.dart';

@JsonSerializable()
class TemplePoojaEntity extends Equatable {
  @JsonKey(name: "pooja_desc")
  final String? poojaDesc;
  @JsonKey(name: "alangaram")
  final String? alangaram;
  @JsonKey(name: "pooja_time")
  final String? poojaTime;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const TemplePoojaEntity({
    this.poojaDesc,
    this.alangaram,
    this.poojaTime,
    this.errorCode,
    this.responseDesc,
  });

  factory TemplePoojaEntity.fromJson(Map<String, dynamic> json) =>
      _$TemplePoojaEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TemplePoojaEntityToJson(this);

  @override
  List<Object?> get props {
    return [
      poojaDesc,
      alangaram,
      poojaTime,
      errorCode,
      responseDesc,
    ];
  }
}
