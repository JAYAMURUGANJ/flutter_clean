import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calendar_event_event.dart';
part 'calendar_event_state.dart';

class CalendarEventBloc extends Bloc<CalendarEventEvent, CalendarEventState> {
  CalendarEventBloc() : super(CalendarEventInitial()) {
    on<CalendarEventEvent>((event, emit) {});
  }
}
