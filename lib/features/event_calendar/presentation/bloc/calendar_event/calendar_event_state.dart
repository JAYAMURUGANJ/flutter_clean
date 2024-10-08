part of 'calendar_event_bloc.dart';

abstract class CalendarEventState {
  final List<dynamic>? calendarEvent;
  final String? responseStatus;
  final DioException? error;
  const CalendarEventState(
      {this.calendarEvent, this.responseStatus, this.error});
}

class CalendarEventInitial extends CalendarEventState {}

class CalendarEventsLoading extends CalendarEventState {
  const CalendarEventsLoading();
}

class CalendarEventLoaded extends CalendarEventState {
  const CalendarEventLoaded(List<CalendarEventEntity>? calendarEvent)
      : super(calendarEvent: calendarEvent);
}

class CalendarEventLoadingSomthingWentWrong extends CalendarEventState {
  const CalendarEventLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class CalendarEventLoadingError extends CalendarEventState {
  const CalendarEventLoadingError(DioException error) : super(error: error);
}
