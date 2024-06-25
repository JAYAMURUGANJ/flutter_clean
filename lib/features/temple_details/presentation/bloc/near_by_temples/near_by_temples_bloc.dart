import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/near_by_temples.dart';
import '../../../domain/usecases/near_by_temple_usecase.dart';
import '/core/models/itms_request.dart';
import '/core/resources/data_state.dart';
import '/core/resources/itms_request_handler.dart';

part 'near_by_temples_event.dart';
part 'near_by_temples_state.dart';

class NearbyTemplesBloc extends Bloc<NearbyTemplesEvent, NearByTemplesState> {
  final NearByTemplesUseCase _getNearByTemplesUseCase;
  List<NearByTemplesEntity> nearByTemples = [];
  NearbyTemplesBloc(this._getNearByTemplesUseCase)
      : super(NearByTemplesInitial()) {
    on<GetNearByTemplesEvent>(onGetNearByTemplesLocation);
  }

  void onGetNearByTemplesLocation(
      GetNearByTemplesEvent event, Emitter<NearByTemplesState> emit) async {
    String serviceId = "7011";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getNearByTemplesUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        nearByTemples = dataState.resultSet!;
        emit(NearByTemplesLoaded(nearByTemples));
      } else {
        emit(NearByTemplesLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc!));
      }
    }
    if (dataState is DataFailed) {
      emit(NearByTemplesLoadingError(dataState.error!));
    }
    //[ { "result_set": [ { "location_desc": "Airport", "location_from": "Chennai International Airport", "distance": "11", "blueprint_image": [], "longitude": "", "latitude": "" }, { "location_desc": "Railway Station", "location_from": "Chennai Central Train Station", "distance": "6", "blueprint_image": [], "longitude": "", "latitude": "" } ], "response_status": "SUCCESS" } ]
  }
}
