part of 'current_location_bloc.dart';

class CurrentLocationEvent {
  const CurrentLocationEvent();
}

class GetCurrentLocation extends CurrentLocationEvent {
  final String page;
  GetCurrentLocation(this.page);
}
