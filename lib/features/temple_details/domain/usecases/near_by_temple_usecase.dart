import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/near_by_temples.dart';
import '../repository/near_by_temples_repository.dart';

class NearByTemplesUseCase
    implements UseCase<DataState<List<NearByTemplesEntity>>, void> {
  final NearByTemplesRepository _nearByTemplesRepository;

  NearByTemplesUseCase(
    this._nearByTemplesRepository,
  );

  @override
  Future<DataState<List<NearByTemplesEntity>>> call(
          formData, serviceId) async =>
      await _nearByTemplesRepository.getResponse(formData, serviceId);
}
