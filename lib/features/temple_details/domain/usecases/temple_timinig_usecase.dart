import 'package:news_app_clean_architecture/features/temple_details/domain/entities/temple_timing.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/repository/temple_timing_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

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
