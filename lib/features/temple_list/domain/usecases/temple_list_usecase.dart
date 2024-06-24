import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/temple_list.dart';
import '../repository/temple_list_repository.dart';

class TempleListUseCase
    implements UseCase<DataState<List<TempleListEntity>>, void> {
  final TempleListRepository _templeListRepository;

  TempleListUseCase(
    this._templeListRepository,
  );

  @override
  Future<DataState<List<TempleListEntity>>> call(formData, serviceId) async =>
      await _templeListRepository.getTempleList(formData, serviceId);
}
