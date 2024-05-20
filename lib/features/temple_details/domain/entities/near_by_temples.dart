import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'near_by_temples.g.dart';

@JsonSerializable()
class NearByTemplesEntity extends Equatable {
  @JsonKey(name: "location_desc")
  final String? locationDesc;
  @JsonKey(name: "location_from")
  final String? locationFrom;
  @JsonKey(name: "distance")
  final String? distance;
  @JsonKey(name: "blueprint_image")
  final List<dynamic>? blueprintImage;
  @JsonKey(name: "longitude")
  final String? longitude;
  @JsonKey(name: "latitude")
  final String? latitude;
  @JsonKey(name: 'error_code')
  final String? errorCode;
  @JsonKey(name: 'response_desc')
  final String? responseDesc;

  const NearByTemplesEntity({
    this.locationDesc,
    this.locationFrom,
    this.distance,
    this.blueprintImage,
    this.longitude,
    this.latitude,
    this.errorCode,
    this.responseDesc,
  });

  factory NearByTemplesEntity.fromJson(Map<String, dynamic> json) =>
      _$NearByTemplesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NearByTemplesEntityToJson(this);

  @override
  List<Object?> get props {
    return [
      locationDesc,
      locationFrom,
      distance,
      blueprintImage,
      longitude,
      latitude,
      errorCode,
      responseDesc,
    ];
  }
}
