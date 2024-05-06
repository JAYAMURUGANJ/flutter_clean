import '/core/resources/data_state.dart';
import '/features/dashboard/domain/entities/whats_new.dart';

abstract class WhatsNewRepository {
  // API methods
  Future<DataState<List<WhatsNewEntity>>> getResponse(
      formData, String serviceId);
}
