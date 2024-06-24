import '../entities/temple_list.dart';
import '/core/resources/data_state.dart';

abstract class TempleListRepository {
  // API methods
  Future<DataState<List<TempleListEntity>>> getTempleList(
      String formData, String serviceId);
}
