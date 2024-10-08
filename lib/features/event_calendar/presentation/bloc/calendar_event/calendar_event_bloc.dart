import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/itms_request.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/itms_request_handler.dart';
import '../../../domain/entities/calendar_event.dart';
import '../../../domain/usecases/calendar_event_usecase.dart';

part 'calendar_event_event.dart';
part 'calendar_event_state.dart';

class CalendarEventBloc extends Bloc<CalendarEventEvent, CalendarEventState> {
  final CalendarEventUseCase _getCalendarEventUseCase;

  List<CalendarEventEntity> calendarEvents = [];
  CalendarEventBloc(this._getCalendarEventUseCase)
      : super(CalendarEventInitial()) {
    on<GetCalendarEvent>(onGetCalenderevent);
  }

  void onGetCalenderevent(
      GetCalendarEvent event, Emitter<CalendarEventState> emit) async {
    emit(const CalendarEventsLoading());
    String serviceId = (event.templeId != null &&
            event.templeId!.isNotEmpty &&
            event.templeId != "null")
        ? "7025"
        : "7023";
    String formData = ITMSRequestHandler(serviceId, [
      (event.templeId != null &&
              event.templeId!.isNotEmpty &&
              event.templeId != "null")
          ? FilterData(
              templeId: event.templeId, festivalMonth: event.filterMonth)
          : FilterData(festivalMonth: event.filterMonth)
    ]).getFormData();
    DataState<List<CalendarEventEntity>> dataState =
        await _getCalendarEventUseCase(formData, serviceId);
    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        calendarEvents = dataState.resultSet!;
        emit(CalendarEventLoaded(calendarEvents));
      } else {
        emit(CalendarEventLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc!));
      }
    }
    if (dataState is DataFailed) {
      emit(CalendarEventLoadingError(dataState.error!));
    }
  }
}
