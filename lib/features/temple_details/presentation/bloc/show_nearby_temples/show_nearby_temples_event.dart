part of 'show_nearby_temples_bloc.dart';

abstract class ShowNearbyTemplesEvent {
  const ShowNearbyTemplesEvent();
}

class ViewSingleTempleEvent extends ShowNearbyTemplesEvent {
  final ItmsResponseEntity temple;
  final CustomInfoWindowController customInfoWindowController;
  ViewSingleTempleEvent(this.temple, this.customInfoWindowController);
}

class ViewNearByTemplesEvent extends ShowNearbyTemplesEvent {
  final ItmsResponseEntity currentTemple;
  final List<ItmsResponseEntity> listOfTemples;
  final CustomInfoWindowController customInfoWindowController;
  final double distance;
  ViewNearByTemplesEvent(
      {required this.currentTemple,
      required this.listOfTemples,
      required this.customInfoWindowController,
      required this.distance});
}
