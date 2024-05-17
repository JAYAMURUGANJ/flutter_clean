import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/live_events.dart';
import '/core/models/itms_request.dart';
import '/core/resources/data_state.dart';
import '/core/resources/itms_request_handler.dart';
import '/features/dashboard/domain/usecases/live_events_usecase.dart';

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
        emit(LiveEventsSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "templeid": "TM000001", "temple_id": 1, "temple_name": "Arulmigu Kapaleeswarar Temple, Mylapore, Chennai - 600004", "ttemple_name": "அருள்மிகு கபாலீசுவரர் திருக்கோயில், மயிலாப்பூர், சென்னை - 600004", "event_desc": "Urchavar live", "from_date": "2023-05-17", "to_date": "2024-05-17", "file_info": [], "event_url": "https://www.youtube.com/channel/UCib-68i9VnfVreI0W8kznjg/live", "content_type": "U", "liveurl": "Y", "liveurl_type": "U", "telecast_timing": [ { "to_time": "11:59 PM", "from_time": "12:00 AM" } ], "function_date": "", "published_from": "2023-05-17", "published_upto": "2024-05-17", "maintower_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlX2ltYWdlcy8xLzEyOTQ2L2RvY3VtZW50XzEuanBn" } ] } ], "response_status": "SUCCESS" } ]
  }
}
