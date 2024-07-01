import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/models/itms_request.dart';
import '/core/resources/data_state.dart';
import '/core/resources/itms_request_handler.dart';
import '/features/temple_details/domain/entities/shrines_details.dart';
import '/features/temple_details/domain/usecases/shrines_details_usecase.dart';

part 'shrines_event.dart';
part 'shrines_state.dart';

class ShrinesBloc extends Bloc<ShrinesEvent, ShrinesState> {
  final ShrinesDetailsUseCase _getShrinesDetailsUseCase;
  List<ShrinesDetailsEntity> shrinesDetails = [];
  ShrinesBloc(this._getShrinesDetailsUseCase) : super(ShrinesInitial()) {
    on<GetShrinesEvent>(onGetShrines);
  }

  void onGetShrines(GetShrinesEvent event, Emitter<ShrinesState> emit) async {
    emit(const ShrinesLoading());
    String serviceId = "7005";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getShrinesDetailsUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        shrinesDetails = dataState.resultSet!;
        emit(ShrinesLoaded(shrinesDetails));
      } else {
        emit(ShrinesLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc!));
      }
    }

    if (dataState is DataFailed) {
      emit(ShrinesLoadingError(dataState.error!));
    }
  }
}
