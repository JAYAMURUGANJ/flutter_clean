// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'temple_info.g.dart';

// @JsonSerializable()
// class CalendarEventsEntity extends Equatable {
//   @JsonKey(name: "description")
//   final String? description;
//   @JsonKey(name: "moolavar_swami_name")
//   final String? moolavarSwamiName;
//   @JsonKey(name: "moolavar_ambal_name")
//   final String? moolavarAmbalName;
//   @JsonKey(name: "aagamam_desc")
//   final dynamic aagamamDesc;
//   @JsonKey(name: "poet_name")
//   final String? poetName;
//   @JsonKey(name: "historical_name")
//   final dynamic historicalName;
//   @JsonKey(name: "sthala_virutcham")
//   final String? sthalaVirutcham;
//   @JsonKey(name: "temple_theertham")
//   final String? templeTheertham;
//   @JsonKey(name: "temple_images")
//   final List<TempleImage>? templeImages;
//   @JsonKey(name: 'error_code')
//   final String? errorCode;
//   @JsonKey(name: 'response_desc')
//   final String? responseDesc;

//   const CalendarEventsEntity({
//     this.description,
//     this.moolavarSwamiName,
//     this.moolavarAmbalName,
//     this.aagamamDesc,
//     this.poetName,
//     this.historicalName,
//     this.sthalaVirutcham,
//     this.templeTheertham,
//     this.templeImages,
//     this.errorCode,
//     this.responseDesc,
//   });

//   factory CalendarEventsEntity.fromJson(Map<String, dynamic> json) =>
//       _$CalendarEventsEntityFromJson(json);

//   Map<String, dynamic> toJson() => _$CalendarEventsEntityToJson(this);

//   @override
//   List<Object?> get props {
//     return [
//       description,
//       moolavarSwamiName,
//       moolavarAmbalName,
//       aagamamDesc,
//       poetName,
//       historicalName,
//       sthalaVirutcham,
//       templeTheertham,
//       templeImages,
//       errorCode,
//       responseDesc,
//     ];
//   }
// }
