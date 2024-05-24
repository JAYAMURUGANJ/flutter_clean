import 'dart:async';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

import '../../../../../config/common/class/app_info.dart';

part 'current_location_event.dart';
part 'current_location_state.dart';

Location _location = Location();

class CurrentLocationBloc
    extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  CurrentLocationBloc() : super(CurrentLocationInitial()) {
    on<CurrentLocationEvent>((event, emit) {});
    on<GetCurrentLocation>(fetchCurrentLocation);
  }
  // void _launchMap(String page) {
  //   AppInfo().getCurrentLocation().then((locationData) => showDialog(
  //       context: context,
  //       builder: ((context) {
  //         return AlertDialog.adaptive(
  //           title: const LocaleText('select_distance'),
  //           content: Wrap(
  //             alignment: WrapAlignment.spaceAround,
  //             runAlignment: WrapAlignment.spaceBetween,
  //             children: List.generate(
  //               distanceList.length,
  //               (index) => ChoiceChip(
  //                 showCheckmark: false,
  //                 label: Text(distanceList[index].round().toString()),
  //                 selected: selectedDistanceIndex == index,
  //                 onSelected: (value) {
  //                   selectedDistanceIndex = index;
  //                   print(distanceList[index]);
  //                 },
  //               ),
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('cancel')),
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   pageNavigation(page.toString(), context, arguments: {
  //                     "current_location": locationData,
  //                     "distance": distanceList[selectedDistanceIndex]
  //                   });
  //                 },
  //                 child: const Text('confirm')),
  //           ],
  //         );
  //       })));
  // }

  fetchCurrentLocation(
      GetCurrentLocation event, Emitter<CurrentLocationState> emit) async {
    await checkPermission().then((status) async {
      print("status $status");
      if (status == PermissionStatus.granted ||
          status == PermissionStatus.grantedLimited) {
        print("entered");
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
