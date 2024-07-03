import '../entities/district_entity.dart';
import '/core/resources/data_state.dart';

abstract class DistrictRepository {
  // API methods
  Future<DataState<List<DistrictEntity>>> getResponse(
      formData, String serviceId);
}
