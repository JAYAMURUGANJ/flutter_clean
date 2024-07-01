part of 'show_nearby_temples_bloc.dart';

abstract class ShowNearbyTemplesEvent {
  const ShowNearbyTemplesEvent();
}

class ViewCurrentLocationEvent extends ShowNearbyTemplesEvent {
  final bool fromCurrentLocation;
  final LatLng? currentLocationLatLng;
  final List<TempleEntity> listOfTemples;
  final CustomInfoWindowController customInfoWindowController;
  final double distance;
  ViewCurrentLocationEvent(
      {required this.fromCurrentLocation,
      required this.currentLocationLatLng,
      required this.listOfTemples,
      required this.customInfoWindowController,
      required this.distance});
}

class ViewSingleTempleEvent extends ShowNearbyTemplesEvent {
  final TempleEntity temple;
  final CustomInfoWindowController customInfoWindowController;
  ViewSingleTempleEvent(this.temple, this.customInfoWindowController);
}

class ViewNearByTemplesEvent extends ShowNearbyTemplesEvent {
  final bool fromCurrentLocation;
  final TempleEntity? currentTemple;
  final List<TempleEntity> listOfTemples;
  final CustomInfoWindowController customInfoWindowController;
  final double distance;
  final LatLng? currentLocationLatLng;
  ViewNearByTemplesEvent({
    required this.fromCurrentLocation,
    required this.currentTemple,
    required this.listOfTemples,
    required this.customInfoWindowController,
    required this.distance,
    this.currentLocationLatLng,
  });
}
