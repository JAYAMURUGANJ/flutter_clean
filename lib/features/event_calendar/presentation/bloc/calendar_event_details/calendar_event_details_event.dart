part of 'calendar_event_details_bloc.dart';

abstract class CalendarEventDetailsEvent {
  const CalendarEventDetailsEvent();
}

class GetCalendarEventDetails extends CalendarEventDetailsEvent {
  String? templeId;
  String? filterMonth;
  String? festivalDate;
  String? festivalCode;
  GetCalendarEventDetails({
    this.templeId,
    this.filterMonth,
    this.festivalDate,
    this.festivalCode,
  });
}
