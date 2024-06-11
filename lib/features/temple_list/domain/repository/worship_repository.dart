import '../entities/worship.dart';
import '/core/resources/data_state.dart';

abstract class WorshipRepository {
  // API methods
  Future<DataState<List<WorshipEntity>>> getResponse(
      formData, String serviceId);
}
