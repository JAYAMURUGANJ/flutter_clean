import '../../../../core/resources/data_state.dart';
import '../entities/calendar_event_details.dart';

abstract class CalendarEventDetailsRepository {
  // API methods
  Future<DataState<List<CalendarEventDetailsEntity>>> getResponse(
      formData, String serviceId);
}
