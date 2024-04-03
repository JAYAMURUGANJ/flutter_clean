import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/temple_info.dart';
import '../repository/temple_info_repository.dart';

class TempleInfoUseCase
    implements UseCase<DataState<List<TempleInfoEntity>>, void> {
  final TempleInfoRepository _templeInfoRepository;

  TempleInfoUseCase(
    this._templeInfoRepository,
  );

  @override
  Future<DataState<List<TempleInfoEntity>>> call(formData, serviceId) async =>
      await _templeInfoRepository.getResponse(formData, serviceId);
}
