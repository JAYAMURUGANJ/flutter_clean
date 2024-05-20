import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/google_map_location.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/itms_response.dart';
import 'dart:math' as Math;

part 'show_nearby_temples_event.dart';
part 'show_nearby_temples_state.dart';

class ShowNearbyTemplesBloc
    extends Bloc<ShowNearbyTemplesEvent, ShowNearbyTemplesState> {
  ShowNearbyTemplesBloc() : super(ShowNearbyTemplesInitial()) {
    on<ShowNearbyTemplesEvent>((event, emit) {});
    on<ViewSingleTempleEvent>(viewSingleTemple);
    on<ViewNearByTemplesEvent>(viewNearbyTemples);
  }

  viewSingleTemple(
      ViewSingleTempleEvent event, Emitter<ShowNearbyTemplesState> emit) async {
    if (event.temple != null) {
      Set<Marker> markers;
      markers = {
        Marker(
          markerId: MarkerId(event.temple.templeId.toString()),
          position: LatLng(double.parse(event.temple.templeLatitude.toString()),
              double.parse(event.temple.templeLangitude.toString())),
          onTap: () {
            event.customInfoWindowController.addInfoWindow!(
              BuildMarkerInfoWidget(
                  temple: event.temple,
                  customInfoWindowController: event.customInfoWindowController),
              LatLng(double.parse(event.temple.templeLatitude.toString()),
                  double.parse(event.temple.templeLangitude.toString())),
            );
          },
        )
      };
      // final BitmapDescriptor customIcon = await getMarkerIcon(
      //     event.temple.maintowerImage!.isNotEmpty
      //         ? 'https://hrce.tn.gov.in/webservice/documentview.php?file_path=${event.temple.maintowerImage![0].fileLocation}'
      //         : NetworkImages.templePlaceHolder,
      //     const Size(200, 200));
      emit(ViewMarkersState(markers));
    } else {
      //  emit();
    }
  }

  viewNearbyTemples(
      ViewNearByTemplesEvent event, Emitter<ShowNearbyTemplesState> emit) {
    if (event.listOfTemples.isNotEmpty) {
      // filter radius data
      var filteredTemples = event.listOfTemples
          .where((marker) =>
              calculateDistance(
                  LatLng(
                    double.tryParse(event.currentTemple.templeLatitude!)!,
                    double.tryParse(event.currentTemple.templeLangitude!)!,
                  ),
                  LatLng(
                    double.tryParse(marker.templeLatitude!)!,
                    double.tryParse(marker.templeLangitude!)!,
                  )) <=
              event.distance)
          .toList();
      //
      Set<Marker> setOfMarkers = {};
      Iterable<Marker> markerItems =
          Iterable.generate(filteredTemples.length, (index) {
        return Marker(
          markerId: MarkerId(filteredTemples[index].templeId.toString()),
          position: LatLng(
              double.parse(filteredTemples[index].templeLatitude.toString()),
              double.parse(filteredTemples[index].templeLangitude.toString())),
          onTap: () {
            event.customInfoWindowController.addInfoWindow!(
              BuildMarkerInfoWidget(
                  temple: filteredTemples[index],
                  customInfoWindowController: event.customInfoWindowController),
              LatLng(
                  double.parse(
                      filteredTemples[index].templeLatitude.toString()),
                  double.parse(
                      filteredTemples[index].templeLangitude.toString())),
            );
          },
        );
      });
      setOfMarkers = Set.from(markerItems);
      emit(ViewMarkersState(setOfMarkers, filteredTemples: filteredTemples));
    } else {
      emit(ShowMarkerSWWState());
    }
  }

  List<Marker> filterMarkersByRadius(
      List<Marker> allMarkers, LatLng center, double radius) {
    return allMarkers
        .where((marker) => calculateDistance(center, marker.position) <= radius)
        .toList();
  }

  double calculateDistance(LatLng p1, LatLng p2) {
    const double radius = 6371; // Earth's radius in kilometers
    var lat1 = deg2rad(p1.latitude);
    var lat2 = deg2rad(p2.latitude);
    var lon1 = deg2rad(p1.longitude);
    var lon2 = deg2rad(p2.longitude);
    var dLat = lat2 - lat1;
    var dLon = lon2 - lon1;

    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(lat1) *
            Math.cos(lat2) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    return radius * c;
  }

  double deg2rad(double deg) => deg * (Math.pi / 180);

// get current location
  // Future<LatLng> getCurrentLocation() async {
  //   LocationPermission permission;
  //   permission = await Geolocator.requestPermission();

  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   double lat = position.latitude;
  //   double long = position.longitude;

  //   LatLng location = LatLng(lat, long);
  //   return location;
  // }
}
