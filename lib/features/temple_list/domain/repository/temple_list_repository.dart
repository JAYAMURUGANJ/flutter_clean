import '/core/resources/data_state.dart';
import '../entities/temple_list_response.dart';

abstract class ItmsRepository {
  // API methods
  Future<DataState<List<ItmsResponseEntity>>> getResponse(
      formData, String serviceId);
}
