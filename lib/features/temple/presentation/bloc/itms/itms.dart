import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/resources/itms_request.dart';

import '../../../../../core/models/itms_request.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../domain/usecases/itms_response.dart';
import 'itms_event.dart';
import 'itms_state.dart';

class ITMSBloc extends Bloc<ITMSEvent, ITMSState> {
  final ItmsResponseUseCase _getTempleListUseCase;

  ITMSBloc(this._getTempleListUseCase) : super(const TempleListLoading()) {
    on<GetTempleList>(onGetTempleList);
  }

  void onGetTempleList(GetTempleList event, Emitter<ITMSState> emit) async {
    String formData =
        ITMSRequestHandler("7019", [FilterData(degree360Avail: "Y")])
            .getFormData();

    final dataState = await _getTempleListUseCase(formData, "7019");

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }

    if (dataState is DataFailed) {
      emit(TempleListLodingError(dataState.error!));
    }
  }
}
