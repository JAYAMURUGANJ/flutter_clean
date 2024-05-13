import 'package:news_app_clean_architecture/features/event_calendar/domain/entities/calendar_event.dart';
import 'package:news_app_clean_architecture/features/event_calendar/domain/repository/calendar_event_repository.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class CalendarEventUseCase
    implements UseCase<DataState<List<CalendarEventEntity>>, void> {
  final CalendarEventRepository _calendarEventRepository;

  CalendarEventUseCase(
    this._calendarEventRepository,
  );

  @override
  Future<DataState<List<CalendarEventEntity>>> call(
          formData, serviceId) async =>
      await _calendarEventRepository.getResponse(formData, serviceId);
}
