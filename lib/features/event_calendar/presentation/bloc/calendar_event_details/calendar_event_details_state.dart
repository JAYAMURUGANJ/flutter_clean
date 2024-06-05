part of 'calendar_event_details_bloc.dart';

abstract class CalendarEventDetailsState {
  final List<dynamic>? calendarEventDetails;
  final String? responseStatus;
  final DioException? error;
  const CalendarEventDetailsState(
      {this.calendarEventDetails, this.responseStatus, this.error});
}

class CalendarEventDetailsInitial extends CalendarEventDetailsState {}

class CalendarEventDetailsLoading extends CalendarEventDetailsState {
  const CalendarEventDetailsLoading();
}

class CalendarEventDetailsLoaded extends CalendarEventDetailsState {
  const CalendarEventDetailsLoaded(
      List<CalendarEventDetailsEntity> calendarEventDetails)
      : super(calendarEventDetails: calendarEventDetails);
}

class CalendarEventDetailsLoadingSomthingWentWrong
    extends CalendarEventDetailsState {
  const CalendarEventDetailsLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class CalendarEventDetailsLoadingError extends CalendarEventDetailsState {
  const CalendarEventDetailsLoadingError(DioException error)
      : super(error: error);
}
