import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/itms_request.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/itms_request_handler.dart';
import '../../../domain/entities/whats_new.dart';
import '../../../domain/usecases/whats_new_usecase.dart';

part 'whats_new_event.dart';
part 'whats_new_state.dart';

class WhatsNewBloc extends Bloc<WhatsNewEvent, WhatsNewState> {
  final WhatsNewUseCase _getWhatsNewUseCase;
  WhatsNewBloc(this._getWhatsNewUseCase) : super(WhatsNewInitial()) {
    on<GetWhatsNew>(onGetTempleWhatsnew);
  }
  void onGetTempleWhatsnew(
      GetWhatsNew event, Emitter<WhatsNewState> emit) async {
    String serviceId = "7016";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getWhatsNewUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(WhatsNewLoaded(dataState.resultSet!));
      } else {
        emit(WhatsNewLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "dated": "12/10/2022", "title": "test", "description": "temple content", "whatsnew_images": [ { "file_location": "https://hrce.tn.gov.in/demoapp/images/32203.jpg" }, { "file_location": "https://hrce.tn.gov.in/demoapp/images/temple_div.png" } ] } ], "response_status": "SUCCESS" } ]
  }
}
