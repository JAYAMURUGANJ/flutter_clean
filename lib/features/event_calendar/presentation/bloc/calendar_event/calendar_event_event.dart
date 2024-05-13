part of 'calendar_event_bloc.dart';

abstract class CalendarEventEvent {
  const CalendarEventEvent();
}

class GetCalendarEvent extends CalendarEventEvent {
  String? templeId;
  String? filterMonth;
  GetCalendarEvent({this.templeId, this.filterMonth});
}
