import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/contact_details.dart';
import '../repository/contact_details_repository.dart';

class ContactDetailsUseCase
    implements UseCase<DataState<List<ContactDetailsEntity>>, void> {
  final ContactDetailsRepository _contactDetailsRepository;

  ContactDetailsUseCase(
    this._contactDetailsRepository,
  );

  @override
  Future<DataState<List<ContactDetailsEntity>>> call(
          formData, serviceId) async =>
      await _contactDetailsRepository.getResponse(formData, serviceId);
}
