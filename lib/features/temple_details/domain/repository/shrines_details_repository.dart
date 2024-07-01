import '../../../../core/resources/data_state.dart';
import '../entities/shrines_details.dart';

abstract class ShrinesDetailsRepository {
  // API methods
  Future<DataState<List<ShrinesDetailsEntity>>> getResponse(
      formData, String serviceId);
}
