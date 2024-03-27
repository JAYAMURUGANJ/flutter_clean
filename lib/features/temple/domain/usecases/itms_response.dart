import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/itms_response.dart';
import '../repository/itms_repository.dart';

class ItmsResponseUseCase
    implements UseCase<DataState<List<ItmsResponseEntity>>, void> {
  final ItmsRepository _templeRepository;

  ItmsResponseUseCase(
    this._templeRepository,
  );

  @override
  Future<DataState<List<ItmsResponseEntity>>> call(formData, serviceId) async =>
      await _templeRepository.getResponse(formData, serviceId);
}
