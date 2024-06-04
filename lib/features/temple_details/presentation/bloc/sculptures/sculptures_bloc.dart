import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/usecases/sculptures_usecase.dart';

import '../../../../../core/models/itms_request.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/itms_request_handler.dart';
import '../../../domain/entities/sculptures.dart';

part 'sculptures_event.dart';
part 'sculptures_state.dart';

class SculpturesBloc extends Bloc<SculpturesEvent, SculpturesState> {
  final SculpturesUseCase _getSculpturesUseCase;
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
        emit(SculpturesLoaded(dataState.resultSet!));
      } else {
        emit(SculpturesLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc));
      }
    }
  }

  FutureOr<void> onGetSculptureDesc(
      GetSculptureDescEvent event, Emitter<SculpturesState> emit) {
    emit(SculpturesDescView(event.sculpture));
  }
}
