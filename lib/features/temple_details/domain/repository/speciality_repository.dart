import '../../../../core/resources/data_state.dart';
import '../entities/speciality.dart';

abstract class SpecialityRepository {
  // API methods
  Future<DataState<List<SpecialityEntity>>> getResponse(
      formData, String serviceId);
}
