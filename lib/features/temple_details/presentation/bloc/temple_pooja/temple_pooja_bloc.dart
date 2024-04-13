import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/itms_request.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/itms_request_handler.dart';
import '../../../domain/entities/temple_pooja.dart';
import '../../../domain/usecases/temple_pooja_usecase.dart';

part 'temple_pooja_event.dart';
part 'temple_pooja_state.dart';

class TemplePoojaBloc extends Bloc<TemplePoojaEvent, TemplePoojaState> {
  final TemplePoojaUseCase _getTemplePoojaUseCase;
  TemplePoojaBloc(this._getTemplePoojaUseCase) : super(TemplePoojaInitial()) {
    on<GetTemplePooja>(onGetTemplePooja);
  }

  void onGetTemplePooja(
      GetTemplePooja event, Emitter<TemplePoojaState> emit) async {
    emit(const TemplePoojaLoading());
    String serviceId = "7007";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getTemplePoojaUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TemplePoojaLoaded(dataState.resultSet!));
      } else {
        emit(TemplePoojaLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    // [ { "result_set": [ { "pooja_desc": "Ko Pooja", "alangaram": "Flower and Kunkumam and Santhanam", "pooja_time": "05:30 AM to 06:00 AM" }, { "pooja_desc": "Vaikarai Pooja", "alangaram": "Abhishegam and Alangaram", "pooja_time": "06:00 AM to 07:00 AM" }, { "pooja_desc": "Kalasandhi pooja", "alangaram": "Abhishegam and Alangaram", "pooja_time": "08:00 AM to 09:30 PM" }, { "pooja_desc": "Uchikkala Pooja", "alangaram": "Abhishegam and Alangaram", "pooja_time": "11:00 AM to 12:30 PM" }, { "pooja_desc": "Sayaraksha Pooja (Evening)", "alangaram": "Abishegam and Alangaram", "pooja_time": "04:00 PM to 06:30 PM" }, { "pooja_desc": "Ushakala poojai", "alangaram": "", "pooja_time": "06:30 PM to 07:00 PM" }, { "pooja_desc": "Ardhajama Pooja", "alangaram": "Abhishegam and Alangaram", "pooja_time": "09:00 PM to 09:30 PM" } ], "response_status": "SUCCESS" } ]
    if (dataState is DataFailed) {
      emit(TemplePoojaLodingError(dataState.error!));
    }
  }
}
