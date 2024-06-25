import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/sculpture.dart';
import '/core/models/itms_request.dart';
import '/core/resources/data_state.dart';
import '/core/resources/itms_request_handler.dart';
import '/features/temple_details/domain/usecases/sculptures_usecase.dart';

part 'sculptures_event.dart';
part 'sculptures_state.dart';

class SculpturesBloc extends Bloc<SculpturesEvent, SculpturesState> {
  final SculpturesUseCase _getSculpturesUseCase;
  List<SculptureEntity> sculptures = [];

  SculpturesBloc(this._getSculpturesUseCase) : super(SculpturesInitial()) {
    on<GetSculpturesEvent>(onGetSculptures);
    on<GetSculptureDescEvent>(onGetSculptureDesc);
  }

  void onGetSculptures(
      GetSculpturesEvent event, Emitter<SculpturesState> emit) async {
    emit(const SculpturesLoading());
    String serviceId = "7021";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getSculpturesUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        sculptures = dataState.resultSet!;
        emit(SculpturesLoaded(sculptures));
      } else {
        emit(SculpturesLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc));
      }
    }
    if (dataState is DataFailed) {
      emit(SculpturesLoadingError(dataState.error!));
    }
  }

  FutureOr<void> onGetSculptureDesc(
      GetSculptureDescEvent event, Emitter<SculpturesState> emit) {
    emit(SculpturesDescView(event.sculpture));
  }
}
