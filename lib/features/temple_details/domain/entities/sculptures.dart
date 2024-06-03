import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sculptures.g.dart';

@JsonSerializable()
class SculpturesEntity extends Equatable {
  @JsonKey(name: "sculptures_name")
  final String? sculpturesName;
  @JsonKey(name: "sculpture_desc")
  final String? sculptureDesc;
  @JsonKey(name: "sculpture_info")
  final List<SculptureInfo>? sculptureInfo;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const SculpturesEntity({
    this.sculpturesName,
    this.sculptureDesc,
    this.sculptureInfo,
    this.errorCode,
    this.responseDesc,
  });

  factory SculpturesEntity.fromJson(Map<String, dynamic> json) =>
      _$SculptureEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SculptureEntityToJson(this);
  @override
  List<Object?> get props {
    return [
      sculpturesName,
      sculptureDesc,
      sculptureInfo,
      errorCode,
      responseDesc,
    ];
  }
}

@JsonSerializable()
class SculptureInfo {
  @JsonKey(name: "file_location")
  final String? fileLocation;

  SculptureInfo({
    this.fileLocation,
  });

  factory SculptureInfo.fromJson(Map<String, dynamic> json) =>
      _$SculptureInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SculptureInfoToJson(this);
}
