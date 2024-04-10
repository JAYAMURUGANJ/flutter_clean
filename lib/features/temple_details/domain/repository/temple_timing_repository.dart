import '../../../../core/resources/data_state.dart';
import '../entities/temple_timing.dart';

abstract class TempleTimingRepository {
  // API methods
  Future<DataState<List<TempleTimingEntity>>> getResponse(
      formData, String serviceId);
}
