import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/models/itms_request.dart';
import '/core/resources/data_state.dart';
import '/core/resources/itms_request_handler.dart';
import '/features/dashboard/domain/usecases/live_events_usecase.dart';
import '../../../domain/entities/live_events.dart';

part 'live_events_event.dart';
part 'live_events_state.dart';

class LiveEventsBloc extends Bloc<LiveEventsEvent, LiveEventsState> {
  final LiveEventsUseCase _getLiveEventsUseCase;
  LiveEventsBloc(this._getLiveEventsUseCase) : super(LiveEventsInitial()) {
    on<GetLiveEvents>(onGetTempleScrollevent);
  }

  void onGetTempleScrollevent(
      GetLiveEvents event, Emitter<LiveEventsState> emit) async {
    String serviceId = "7016";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getLiveEventsUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(LiveEventsLoaded(dataState.resultSet!));
      } else {
        emit(
            LiveEventsSomthingWentWrong(dataState.resultSet![0].responseDesc!));
      }
    }
  }
}
