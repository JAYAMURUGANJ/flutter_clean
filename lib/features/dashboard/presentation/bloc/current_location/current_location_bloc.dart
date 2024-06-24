import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

part 'current_location_event.dart';
part 'current_location_state.dart';

Location _location = Location();

class CurrentLocationBloc
    extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  CurrentLocationBloc() : super(CurrentLocationInitial()) {
    on<CurrentLocationEvent>((event, emit) {});
    on<SetCurrentLocationInitial>((event, emit) {
      emit(CurrentLocationInitial());
    });
    on<GetCurrentLocation>(fetchCurrentLocation);
  }

  fetchCurrentLocation(
      GetCurrentLocation event, Emitter<CurrentLocationState> emit) async {
    await checkPermission().then((status) async {
      if (status == PermissionStatus.granted ||
          status == PermissionStatus.grantedLimited) {
        emit(CurrentLocationLoading());
        await getCurrentLocation().then((locationData) {
          emit(CurrentLocationSuccess(event.page, locationData));
        });
      } else {
        emit(CurrentLocationFailed(status == PermissionStatus.deniedForever
            ? "Permission denied permanently.Please Enable it on phone settings"
            : "Permission denied"));
      }
    });
  }

  checkPermission() async {
    PermissionStatus status = await _location.hasPermission();
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.deniedForever) {
      status = await _location.requestPermission();
    }
    return status;
  }

  Future<LocationData> getCurrentLocation() async {
    try {
      return await _location.getLocation();
    } catch (e) {
      rethrow;
    }
  }
}
