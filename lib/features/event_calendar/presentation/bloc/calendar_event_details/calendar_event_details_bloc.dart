import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/event_calendar/domain/usecases/calendar_event_details_usecase.dart';

import '../../../../../core/models/itms_request.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/itms_request_handler.dart';
import '../../../domain/entities/calendar_event_details.dart';

part 'calendar_event_details_event.dart';
part 'calendar_event_details_state.dart';

class CalendarEventDetailsBloc
    extends Bloc<CalendarEventDetailsEvent, CalendarEventDetailsState> {
  final CalendarEventDetailsUseCase _getCalendarEventDetailsUseCase;
  List<CalendarEventDetailsEntity> calendarEventDetails = [];
  CalendarEventDetailsBloc(this._getCalendarEventDetailsUseCase)
      : super(CalendarEventDetailsInitial()) {
    on<GetCalendarEventDetails>(onGetCalendereventDetails);
  }

  void onGetCalendereventDetails(GetCalendarEventDetails event,
      Emitter<CalendarEventDetailsState> emit) async {
    String serviceId = "7024";
    String formData = ITMSRequestHandler(serviceId, [
      FilterData(
          festivalDate: event.festivalDate, festivalCode: event.festivalCode)
    ]).getFormData();
    final dataState =
        await _getCalendarEventDetailsUseCase(formData, serviceId);
    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        calendarEventDetails = dataState.resultSet!;
        emit(CalendarEventDetailsLoaded(calendarEventDetails));
      } else {
        emit(CalendarEventDetailsLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc!));
      }
    }

    if (dataState is DataFailed) {
      emit(CalendarEventDetailsLoadingError(dataState.error!));
    }
  }
}
