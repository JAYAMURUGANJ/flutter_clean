import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/usecases/get_temple.dart';
import 'temple_list_event.dart';
import 'temple_list_state.dart';

class TempleListBloc extends Bloc<TempleListEvent, TempleListState> {
  final GetTempleUseCase _getTempleListUseCase;

  TempleListBloc(this._getTempleListUseCase)
      : super(const TempleListLoading()) {
    on<GetTempleList>(onGetTempleList);
  }

  void onGetTempleList(
      GetTempleList event, Emitter<TempleListState> emit) async {
    final dataState = await _getTempleListUseCase(event.formData);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
                emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(dataState.responseStatus!));
      }
    }

    if (dataState is DataFailed) {
      emit(TempleListLodingError(dataState.error!));
    }
  }
}
