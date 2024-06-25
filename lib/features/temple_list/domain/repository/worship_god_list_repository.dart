import '../entities/worship_god_list.dart';
import '/core/resources/data_state.dart';

abstract class WorshipRepository {
  // API methods
  Future<DataState<List<WorshipGodEntity>>> getResponse(
      formData, String serviceId);
}
