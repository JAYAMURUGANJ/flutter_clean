import '../../../../core/resources/data_state.dart';
import '../entities/sculptures.dart';

abstract class SculpturesRepository {
  // API methods
  Future<DataState<List<SculpturesEntity>>> getResponse(
      formData, String serviceId);
}
