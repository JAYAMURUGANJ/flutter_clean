import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/speciality.dart';
import '/config/common/class/cryption.dart';
import '/core/models/itms_request.dart';
import '/core/resources/data_state.dart';
import '/core/resources/itms_request_handler.dart';
import '/features/temple_details/domain/usecases/speciality_usecase.dart';

part 'speciality_event.dart';
part 'speciality_state.dart';

class SpecialityBloc extends Bloc<SpecialityEvent, SpecialityState> {
  final SpecialityUseCase _getSpecialityUseCase;
  List<SpecialityEntity> specialities = [];
  SpecialityBloc(this._getSpecialityUseCase) : super(SpecialityInitial()) {
    on<GetSpeciality>(onGetTempleContacts);
  }

  void onGetTempleContacts(
      GetSpeciality event, Emitter<SpecialityState> emit) async {
    emit(const SpecialityLoading());
    String serviceId = "7006";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    debugPrint("form data ${Authentication().decrypt(formData)}");
    final dataState = await _getSpecialityUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        specialities = dataState.resultSet!;
        emit(SpecialityLoaded(specialities));
      } else {
        emit(SpecialityLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc!));
      }
    }

    if (dataState is DataFailed) {
      emit(SpecialityLoadingError(dataState.error!));
    }
  }
}
