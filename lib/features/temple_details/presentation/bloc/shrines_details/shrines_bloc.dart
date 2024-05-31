import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/entities/shrines_details.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/usecases/shrines_details_usecase.dart';

import '../../../../../core/models/itms_request.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/itms_request_handler.dart';

part 'shrines_event.dart';
part 'shrines_state.dart';

class ShrinesBloc extends Bloc<ShrinesEvent, ShrinesState> {
  final ShrinesDetailsUseCase _getShrinesDetailsUseCase;
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
        emit(ShrinesLoaded(dataState.resultSet!));
      } else {
        emit(ShrinesLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
  }
}
