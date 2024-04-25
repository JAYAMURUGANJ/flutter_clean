import '../../../../core/resources/data_state.dart';
import '../entities/live_events.dart';

abstract class LiveEventsRepository {
  // API methods
  Future<DataState<List<LiveEventsEntity>>> getResponse(
      formData, String serviceId);
}
