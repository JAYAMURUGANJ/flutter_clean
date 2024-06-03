import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/shrines_details.dart';
import '../repository/shrines_details_repository.dart';

class ShrinesDetailsUseCase
    implements UseCase<DataState<List<ShrinesDetailsEntity>>, void> {
  final ShrinesDetailsRepository _shrinesDetailsRepository;

  ShrinesDetailsUseCase(
    this._shrinesDetailsRepository,
  );

  @override
  Future<DataState<List<ShrinesDetailsEntity>>> call(
          formData, serviceId) async =>
      await _shrinesDetailsRepository.getResponse(formData, serviceId);
}
