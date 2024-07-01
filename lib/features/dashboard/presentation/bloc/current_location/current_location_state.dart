part of 'current_location_bloc.dart';

class CurrentLocationState {
  const CurrentLocationState();
}

class CurrentLocationInitial extends CurrentLocationState {}

class CurrentLocationLoading extends CurrentLocationState {}

class CurrentLocationSuccess extends CurrentLocationState {
  final String page;
  final LocationData locationData;
  CurrentLocationSuccess(this.page, this.locationData);
}

class CurrentLocationFailed extends CurrentLocationState {
  final String message;
  CurrentLocationFailed(this.message);
}
