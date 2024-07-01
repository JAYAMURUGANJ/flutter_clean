import '../../../../core/resources/data_state.dart';
import '../entities/temple_pooja.dart';

abstract class TemplePoojaRepository {
  // API methods
  Future<DataState<List<TemplePoojaEntity>>> getResponse(
      formData, String serviceId);
}
