import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/temple_pooja.dart';
import '../repository/temple_pooja_repository.dart';

class TemplePoojaUseCase
    implements UseCase<DataState<List<TemplePoojaEntity>>, void> {
  final TemplePoojaRepository _templePoojaRepository;

  TemplePoojaUseCase(
    this._templePoojaRepository,
  );

  @override
  Future<DataState<List<TemplePoojaEntity>>> call(formData, serviceId) async =>
      await _templePoojaRepository.getResponse(formData, serviceId);
}
