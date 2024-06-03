// ignore_for_file: library_prefixes

import 'dart:math' as Math;
import 'dart:ui';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/features/temple_details/presentation/widgets/google_map_location.dart';
import '/features/temple_list/domain/entities/itms_response.dart';

part 'show_nearby_temples_event.dart';
part 'show_nearby_temples_state.dart';

class ShowNearbyTemplesBloc
    extends Bloc<ShowNearbyTemplesEvent, ShowNearbyTemplesState> {
  ShowNearbyTemplesBloc() : super(ShowNearbyTemplesInitial()) {
    on<ShowNearbyTemplesEvent>((event, emit) {});
    on<ViewCurrentLocationEvent>(viewCurrentLocation);
    on<ViewSingleTempleEvent>(viewSingleTemple);
    on<ViewNearByTemplesEvent>(viewNearbyTemples);
  }

  viewSingleTemple(
      ViewSingleTempleEvent event, Emitter<ShowNearbyTemplesState> emit) async {
    emit(ViewNearbyTemplesLoading());
    Set<Marker> markers;

    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(64, 64)),
        'assets/images/icons/marker_1.png');

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
        icon: customIcon,
      )
    };

    emit(ViewMarkersState(markers,
        cameraPosition: CameraPosition(
          target: LatLng(double.parse(event.temple.templeLatitude.toString()),
              double.parse(event.temple.templeLangitude.toString())),
          zoom: 13.4746,
        )));
  }

  viewNearbyTemples(ViewNearByTemplesEvent event,
      Emitter<ShowNearbyTemplesState> emit) async {
    emit(ViewNearbyTemplesLoading());
    if (event.listOfTemples.isNotEmpty) {
      BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(64, 64)),
          'assets/images/icons/marker_1.png');
      // filter radius data
      var filteredTemples = event.listOfTemples
          .where((marker) =>
              calculateDistance(
                  LatLng(
                    double.tryParse(event.currentTemple!.templeLatitude!)!,
                    double.tryParse(event.currentTemple!.templeLangitude!)!,
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
          icon: customIcon,
        );
      });
      setOfMarkers = Set.from(markerItems);
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(
          double.tryParse(event.currentTemple!.templeLatitude!)!,
          double.tryParse(event.currentTemple!.templeLangitude!)!,
        ),
        zoom: 13.4746,
      );
      emit(ViewMarkersState(setOfMarkers,
          filteredTemples: filteredTemples, cameraPosition: cameraPosition));
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

// current location function

  viewCurrentLocation(ViewCurrentLocationEvent event,
      Emitter<ShowNearbyTemplesState> emit) async {
    emit(ViewNearbyTemplesLoading());
    if (event.listOfTemples.isNotEmpty) {
      BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(64, 64)),
          'assets/images/icons/marker_1.png');
      // filter radius data
      var filteredTemples = event.listOfTemples
          .where((marker) =>
              calculateDistance(
                  event.currentLocationLatLng!,
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
          icon: customIcon,
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
      // setOfMarkers.add(Marker(
      //   markerId: const MarkerId("current_temple"),
      //   position: event.currentLocationLatLng!,
      // ));

      emit(ViewMarkersState(
        setOfMarkers,
        filteredTemples: filteredTemples,
      ));
    } else {
      emit(ShowMarkerSWWState());
    }
  }
}
