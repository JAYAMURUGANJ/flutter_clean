import '../../../../core/resources/data_state.dart';
import '../entities/sculpture.dart';

abstract class SculpturesRepository {
  // API methods
  Future<DataState<List<SculptureEntity>>> getResponse(
      formData, String serviceId);
}
