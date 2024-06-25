import 'package:location/location.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/temple_list.dart';

class LocationInfo {
  bool fromCurrent;
  LocationData? currentLocation;
  double? distance;
  TempleEntity? temple;

  LocationInfo({
    required this.fromCurrent,
    this.currentLocation,
    this.distance,
    this.temple,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> jsonData) {
    return LocationInfo(
      fromCurrent: jsonData['from_current'],
      currentLocation: jsonData['current_location'],
      distance: jsonData['distance'],
      temple: jsonData['temple'],
    );
  }

  static Map<String, dynamic> toMap(LocationInfo bookingServices) => {
        'from_current': bookingServices.fromCurrent,
        'current_location': bookingServices.currentLocation,
        'distance': bookingServices.distance,
        'temple': bookingServices.temple,
      };
}
