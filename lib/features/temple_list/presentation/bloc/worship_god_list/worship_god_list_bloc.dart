import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/worship_god_list.dart';
import '../../../domain/usecases/worship_god_list_usecase.dart';
import '/core/resources/data_state.dart';
import '/core/resources/itms_request_handler.dart';

part 'worship_god_list_event.dart';
part 'worship_god_list_state.dart';

class WorshipGodListBloc
    extends Bloc<WorshipGodListEvent, WorshipGodListState> {
  final WorshipUseCase _getWorshipUseCase;
  List<WorshipGodEntity> worshipGods = [];
  WorshipGodListBloc(this._getWorshipUseCase) : super(WorshipInitial()) {
    on<GetWorship>(onGetWorship);
  }

  void onGetWorship(GetWorship event, Emitter<WorshipGodListState> emit) async {
    emit(const WorshipLoading());
    String serviceId = "7022";
    String formData = ITMSRequestHandler(serviceId, null).getFormData();
    final dataState = await _getWorshipUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        worshipGods = dataState.resultSet!;
        emit(WorshipLoaded(worshipGods));
      } else {
        emit(WorshipLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc!));
      }
    }
    if (dataState is DataFailed) {
      emit(WorshipLoadingError(dataState.error!));
    }
  }
}
