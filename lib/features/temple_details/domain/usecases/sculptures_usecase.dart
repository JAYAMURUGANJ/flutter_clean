import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/sculpture.dart';
import '../repository/sculptures_repository.dart';

class SculpturesUseCase
    implements UseCase<DataState<List<SculptureEntity>>, void> {
  final SculpturesRepository _sculpturesRepository;

  SculpturesUseCase(
    this._sculpturesRepository,
  );

  @override
  Future<DataState<List<SculptureEntity>>> call(formData, serviceId) async =>
      await _sculpturesRepository.getResponse(formData, serviceId);
}
