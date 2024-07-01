import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/worship_god_list.dart';
import '../repository/worship_god_list_repository.dart';

class WorshipUseCase
    implements UseCase<DataState<List<WorshipGodEntity>>, void> {
  final WorshipRepository _worshipRepository;

  WorshipUseCase(
    this._worshipRepository,
  );

  @override
  Future<DataState<List<WorshipGodEntity>>> call(formData, serviceId) async =>
      await _worshipRepository.getResponse(formData, serviceId);
}
