import '../../../../core/resources/data_state.dart';
import '../entities/calendar_event.dart';

abstract class CalendarEventRepository {
  // API methods
  Future<DataState<List<CalendarEventEntity>>> getResponse(
      formData, String serviceId);
}
