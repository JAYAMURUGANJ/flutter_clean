import '../../../../core/resources/data_state.dart';
import '../entities/facility.dart';

abstract class FacilityRepository {
  // API methods
  Future<DataState<List<FacilityEntity>>> getResponse(
      formData, String serviceId);
}
