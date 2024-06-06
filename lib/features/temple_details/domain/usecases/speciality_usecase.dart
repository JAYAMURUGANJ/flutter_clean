import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/speciality.dart';
import '../repository/speciality_repository.dart';

class SpecialityUseCase
    implements UseCase<DataState<List<SpecialityEntity>>, void> {
  final SpecialityRepository _specialityRepository;

  SpecialityUseCase(
    this._specialityRepository,
  );

  @override
  Future<DataState<List<SpecialityEntity>>> call(formData, serviceId) async =>
      await _specialityRepository.getResponse(formData, serviceId);
}
