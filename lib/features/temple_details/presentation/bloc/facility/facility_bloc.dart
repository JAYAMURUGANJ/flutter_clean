import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/usecases/facility_usecase.dart';

import '../../../../../core/models/itms_request.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/itms_request_handler.dart';
import '../../../domain/entities/facility.dart';

part 'facility_event.dart';
part 'facility_state.dart';

class FacilityBloc extends Bloc<FacilityEvent, FacilityState> {
  final FacilityUseCase _getFacilityUseCase;
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
        emit(FacilityLoaded(dataState.resultSet!));
      } else {
        emit(FacilityLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
  }
}
