import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/calendar_event_details.dart';
import '../repository/calendar_event_details_repository.dart';

class CalendarEventDetailsUseCase
    implements UseCase<DataState<List<CalendarEventDetailsEntity>>, void> {
  final CalendarEventDetailsRepository _calendarEventDetailsRepository;

  CalendarEventDetailsUseCase(
    this._calendarEventDetailsRepository,
  );

  @override
  Future<DataState<List<CalendarEventDetailsEntity>>> call(
          formData, serviceId) async =>
      await _calendarEventDetailsRepository.getResponse(formData, serviceId);
}
