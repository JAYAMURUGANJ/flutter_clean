import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/facility.dart';
import '../repository/facility_repository.dart';

class FacilityUseCase
    implements UseCase<DataState<List<FacilityEntity>>, void> {
  final FacilityRepository _facilityRepository;

  FacilityUseCase(
    this._facilityRepository,
  );

  @override
  Future<DataState<List<FacilityEntity>>> call(formData, serviceId) async =>
      await _facilityRepository.getResponse(formData, serviceId);
}
