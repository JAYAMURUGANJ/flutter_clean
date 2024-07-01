import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/temple_list.dart';
import '../../../domain/usecases/temple_list_usecase.dart';
import '/core/models/itms_request.dart';
import '/core/resources/data_state.dart';
import '/core/resources/itms_request_handler.dart';
import 'temple_list_event.dart';
import 'temple_list_state.dart';

class TempleListBloc extends Bloc<TempleListEvent, TempleListState> {
  final TempleListUseCase _getItmsResponseUseCase;
  List<TempleEntity> templesList = [];

  TempleListBloc(this._getItmsResponseUseCase)
      : super(const TempleListLoading()) {
    on<GetTempleList>(onGetTempleList);
  }
  void onGetTempleList(
      GetTempleList event, Emitter<TempleListState> emit) async {
    emit(const TempleListLoading());
    //temple list with 360 view and tower image
    String serviceId = "7019";
    String formData = ITMSRequestHandler(
      serviceId,
      [
        FilterData(
          degree360Avail: "Y",
          seniorgradeTemples: event.seniorgradeTemples,
        ),
      ],
    ).getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);
    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        templesList = dataState.resultSet!;
        emit(TempleListLoaded(templesList));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc!));
      }
    }
    if (dataState is DataFailed) {
      emit(TempleListLoadingError(dataState.error!));
    }
  }
}
