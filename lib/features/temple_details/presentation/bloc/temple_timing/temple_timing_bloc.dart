import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/temple_timinig_usecase.dart';
import '/core/models/itms_request.dart';
import '/core/resources/data_state.dart';
import '/core/resources/itms_request_handler.dart';
import '/features/temple_details/domain/entities/temple_timing.dart';

part 'temple_timing_event.dart';
part 'temple_timing_state.dart';

class TempleTimingBloc extends Bloc<TempleTimingEvent, TempleTimingState> {
  final TempleTimingUseCase _getTempleTimingUseCase;
  TempleTimingBloc(this._getTempleTimingUseCase)
      : super(TempleTimingInitial()) {
    on<GetTempleTiming>(onGetTempleTiming);
  }

  void onGetTempleTiming(
      GetTempleTiming event, Emitter<TempleTimingState> emit) async {
    emit(const TempleTimingLoading());
    String serviceId = "7010";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getTempleTimingUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleTimingLoaded(dataState.resultSet!));
      } else {
        emit(TempleTimingLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    emit(TempleTimingLodingError(dataState.error!));
    //[ { "result_set": [ { "mrng_openingtime": "05:30 AM", "mrng_closing_time": "12:30 PM", "evng_opening_time": "04:00 PM", "evng_closing_time": "09:30 PM", "remarks": "Only on Mahashivarathiri Temple will  be opened 24 hrs ( 5.00A.M to next day 5.00A.M)", "closing_time": "[{\"to_time\": \"21:30\", \"order_no\": 1, \"from_time\": \"21:15\"}]" } ], "response_status": "SUCCESS" } ]    emit(TempleListLodingError(dataState.error!));
  }
}
