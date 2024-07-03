import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/itms_request_handler.dart';
import '../../../domain/entities/district_entity.dart';
import '../../../domain/usecases/district_usecase.dart';

part 'district_event.dart';
part 'district_state.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  final DistrictUseCase _getDistrictUseCase;
  List<DistrictEntity> districtList = [];
  DistrictBloc(this._getDistrictUseCase) : super(DistrictInitial()) {
    on<GetDistrict>(onGetDistrict);
  }

  void onGetDistrict(GetDistrict event, Emitter<DistrictState> emit) async {
    emit(const DistrictLoading());
    String serviceId = "7029";
    String formData = ITMSRequestHandler(serviceId, null).getFormData();

    try {
      final dataState = await _getDistrictUseCase(formData, serviceId);

      if (dataState is DataSuccess) {
        if (dataState.responseStatus == "SUCCESS" &&
            dataState.resultSet!.isNotEmpty) {
          districtList = dataState.resultSet!;
          emit(DistrictLoaded(districtList));
        } else {
          emit(DistrictLoadingSomthingWentWrong(
              dataState.resultSet![0].responseDesc!));
        }
      }
      if (dataState is DataFailed) {
        emit(DistrictLoadingError(dataState.error!));
      }
    } catch (e) {
      emit(DistrictLoadingSomthingWentWrong(e.toString()));
    }
  }
}
