import '../entities/temple_list_response.dart';
import '/core/resources/data_state.dart';

abstract class TempleListRepository {
  // API methods
  Future<DataState<List<TempleListResponseEntity>>> getTempleList(
      formData, String serviceId);
}
