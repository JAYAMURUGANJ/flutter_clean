import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/temple_list_response.dart';
import '../repository/temple_list_repository.dart';

class TempleListResponseUseCase
    implements UseCase<DataState<List<TempleListResponseEntity>>, void> {
  final TempleListRepository _templeRepository;

  TempleListResponseUseCase(
    this._templeRepository,
  );

  @override
  Future<DataState<List<TempleListResponseEntity>>> call(
          formData, serviceId) async =>
      await _templeRepository.getTempleList(formData, serviceId);
}
