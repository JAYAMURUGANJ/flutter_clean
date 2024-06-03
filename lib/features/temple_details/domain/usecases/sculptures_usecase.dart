import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/sculptures.dart';
import '../repository/sculptures_repository.dart';

class SculpturesUseCase
    implements UseCase<DataState<List<SculpturesEntity>>, void> {
  final SculpturesRepository _sculpturesRepository;

  SculpturesUseCase(
    this._sculpturesRepository,
  );

  @override
  Future<DataState<List<SculpturesEntity>>> call(formData, serviceId) async =>
      await _sculpturesRepository.getResponse(formData, serviceId);
}
