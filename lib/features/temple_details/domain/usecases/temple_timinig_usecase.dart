import '/core/resources/data_state.dart';
import '/core/usecase/usecase.dart';
import '/features/temple_details/domain/entities/temple_timing.dart';
import '/features/temple_details/domain/repository/temple_timing_repository.dart';

class TempleTimingUseCase
    implements UseCase<DataState<List<TempleTimingEntity>>, void> {
  final TempleTimingRepository _templeTimingRepository;

  TempleTimingUseCase(
    this._templeTimingRepository,
  );

  @override
  Future<DataState<List<TempleTimingEntity>>> call(formData, serviceId) async =>
      await _templeTimingRepository.getResponse(formData, serviceId);
}
