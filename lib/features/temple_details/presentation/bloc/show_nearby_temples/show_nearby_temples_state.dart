part of 'show_nearby_temples_bloc.dart';

abstract class ShowNearbyTemplesState {
  const ShowNearbyTemplesState();
}

class ShowNearbyTemplesInitial extends ShowNearbyTemplesState {}

class ViewMarkersState extends ShowNearbyTemplesState {
  final Set<Marker> markers;
  // final ItmsResponseEntity temple;
  final List<ItmsResponseEntity>? filteredTemples;
  ViewMarkersState(this.markers, {this.filteredTemples});
}

class ViewNearbyTemplesState extends ShowNearbyTemplesState {
  final Set<Marker> markers;
  final List<ItmsResponseEntity> filteredTemples;
  ViewNearbyTemplesState(this.markers, this.filteredTemples);
}

class ShowMarkerSWWState extends ShowNearbyTemplesState {
  ShowMarkerSWWState();
}
