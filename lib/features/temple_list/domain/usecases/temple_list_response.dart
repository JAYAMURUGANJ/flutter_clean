import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/temple_list_response.dart';
import '../repository/temple_list_repository.dart';

class TempleResponseUseCase
    implements UseCase<DataState<List<ItmsResponseEntity>>, void> {
  final ItmsRepository _templeRepository;

  TempleResponseUseCase(
    this._templeRepository,
  );

  @override
  Future<DataState<List<ItmsResponseEntity>>> call(formData, serviceId) async =>
      await _templeRepository.getResponse(formData, serviceId);
}
