import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/facility.dart';
import '/core/models/itms_request.dart';
import '/core/resources/data_state.dart';
import '/core/resources/itms_request_handler.dart';
import '/features/temple_details/domain/usecases/facility_usecase.dart';

part 'facility_event.dart';
part 'facility_state.dart';

class FacilityBloc extends Bloc<FacilityEvent, FacilityState> {
  final FacilityUseCase _getFacilityUseCase;
  List<FacilityEntity> facilities = [];
  FacilityBloc(this._getFacilityUseCase) : super(FacilityInitial()) {
    on<GetFacilityEvent>(onGetFacility);
  }

  void onGetFacility(
      GetFacilityEvent event, Emitter<FacilityState> emit) async {
    emit(const FacilityLoading());
    String serviceId = "7018";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getFacilityUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        facilities = dataState.resultSet!;
        emit(FacilityLoaded(facilities));
      } else {
        emit(FacilityLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc!));
      }
    }

    if (dataState is DataFailed) {
      emit(FacilityLoadingError(dataState.error!));
    }
  }
}
