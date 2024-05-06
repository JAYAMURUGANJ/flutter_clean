import '/core/resources/data_state.dart';
import '/features/temple_list/domain/entities/itms_response.dart';

abstract class ItmsRepository {
  // API methods
  Future<DataState<List<ItmsResponseEntity>>> getResponse(
      formData, String serviceId);
}
