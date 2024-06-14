import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/usecases/worship_usecase.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/itms_request_handler.dart';
import '../../../domain/entities/worship.dart';

part 'worship_event.dart';
part 'worship_state.dart';

class WorshipBloc extends Bloc<WorshipEvent, WorshipState> {
  final WorshipUseCase _getWorshipUseCase;
  WorshipBloc(this._getWorshipUseCase) : super(WorshipInitial()) {
    on<GetWorship>(onGetWorship);
  }

  void onGetWorship(GetWorship event, Emitter<WorshipState> emit) async {
    emit(const WorshipLoading());
    String serviceId = "7022";
    String formData = ITMSRequestHandler(serviceId, null).getFormData();
    final dataState = await _getWorshipUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(WorshipLoaded(dataState.resultSet!));
      } else {
        emit(WorshipLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
  }
}
