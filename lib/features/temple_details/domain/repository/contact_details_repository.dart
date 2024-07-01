import '../../../../core/resources/data_state.dart';
import '../entities/contact_details.dart';

abstract class ContactDetailsRepository {
  // API methods
  Future<DataState<List<ContactDetailsEntity>>> getResponse(
      formData, String serviceId);
}
