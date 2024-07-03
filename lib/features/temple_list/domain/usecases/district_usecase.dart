import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/district_entity.dart';
import '../repository/district_repository.dart';

class DistrictUseCase
    implements UseCase<DataState<List<DistrictEntity>>, void> {
  final DistrictRepository _districtRepository;

  DistrictUseCase(
    this._districtRepository,
  );

  @override
  Future<DataState<List<DistrictEntity>>> call(formData, serviceId) async =>
      await _districtRepository.getResponse(formData, serviceId);
}
