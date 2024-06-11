import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/worship.dart';
import '../repository/worship_repository.dart';

class WorshipUseCase implements UseCase<DataState<List<WorshipEntity>>, void> {
  final WorshipRepository _worshipRepository;

  WorshipUseCase(
    this._worshipRepository,
  );

  @override
  Future<DataState<List<WorshipEntity>>> call(formData, serviceId) async =>
      await _worshipRepository.getResponse(formData, serviceId);
}
