import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/temple_list_response.dart';
import '../../../domain/usecases/temple_list_response.dart';
import '/config/common/class/cryption.dart';
import '/core/models/itms_request.dart';
import '/core/resources/data_state.dart';
import '/core/resources/itms_request_handler.dart';
import 'temple_list_event.dart';
import 'temple_list_state.dart';

class TempleListBloc extends Bloc<TempleListEvent, TempleListState> {
  final TempleListResponseUseCase _getItmsResponseUseCase;
  List<TempleListResponseEntity> templesList = [];

  TempleListBloc(this._getItmsResponseUseCase)
      : super(const TempleListLoading()) {
    on<GetTempleList>(onGetTempleList);
  }
  void onGetTempleList(
      GetTempleList event, Emitter<TempleListState> emit) async {
    emit(const TempleListLoading());
    //temple list with 360 view and tower image
    String serviceId = "7019";
    String formData = ITMSRequestHandler(serviceId, [
      FilterData(
          degree360Avail: "Y", seniorgradeTemples: event.seniorgradeTemples)
    ]).getFormData();

    debugPrint("  temple list ===> ${Authentication().decrypt(formData)}");

    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        templesList = dataState.resultSet!;
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "temple_id": 1, "temple_name": "Arulmigu Kapaleeswarar Temple, Mylapore, Chennai - 600004", "ttemple_name": "அருள்மிகு கபாலீசுவரர் திருக்கோயில், மயிலாப்பூர், சென்னை - 600004", "juris_office_code": 216, "district_code": "02", "taluk_code": "08", "village_code": "004", "temple_typecode": 1, "institute_categorycode": 1, "templesection_code": 3, "management_typecode": 1, "management_subtype_code": 1, "degree_360view": "https://mylaikapaleeswarar.hrce.tn.gov.in/resources/docs/virtualtour/1/index.html", "temple_latitude": "13.033842927075", "temple_langitude": "80.269940923909", "maintower_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlX2ltYWdlcy8xLzEyOTQ2L2RvY3VtZW50XzEuanBn" } ]}] , "response_status": "SUCCESS" } ]
    if (dataState is DataFailed) {
      emit(TempleListLoadingError(dataState.error!));
    }
  }
}
