import '../entities/temple_list.dart';
import '/core/resources/data_state.dart';

abstract class TempleListRepository {
  // API methods
  Future<DataState<List<TempleEntity>>> getTempleList(
      String formData, String serviceId);
}
