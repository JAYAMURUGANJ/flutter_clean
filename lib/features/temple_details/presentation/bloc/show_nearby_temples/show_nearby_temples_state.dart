part of 'show_nearby_temples_bloc.dart';

abstract class ShowNearbyTemplesState {
  const ShowNearbyTemplesState();
}

class ShowNearbyTemplesInitial extends ShowNearbyTemplesState {}

class ViewNearbyTemplesLoading extends ShowNearbyTemplesState {}

class ViewSingleTempleState extends ShowNearbyTemplesState {
  final Set<Marker> markers;
  // final ItmsResponseEntity temple;
  final List<TempleListEntity>? filteredTemples;
  final CameraPosition? cameraPosition;
  ViewSingleTempleState(this.markers,
      {this.filteredTemples, this.cameraPosition});
}

class ViewMarkersState extends ShowNearbyTemplesState {
  final Set<Marker> markers;
  // final ItmsResponseEntity temple;
  final List<TempleListEntity>? filteredTemples;
  final CameraPosition? cameraPosition;
  ViewMarkersState(this.markers, {this.filteredTemples, this.cameraPosition});
}

class ViewNearbyTemplesState extends ShowNearbyTemplesState {
  final Set<Marker> markers;
  final List<TempleListEntity> filteredTemples;
  final CameraPosition? cameraPosition;
  ViewNearbyTemplesState(this.markers, this.filteredTemples,
      {this.cameraPosition});
}

class ShowMarkerSWWState extends ShowNearbyTemplesState {
  ShowMarkerSWWState();
}
