import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/temple/domain/entities/temple.dart';

import '../repository/temple_repository.dart';

class GetTempleUseCase implements UseCase<DataState<List<TempleEntity>>, void> {
  final TempleRepository _templeRepository;

  GetTempleUseCase(
    this._templeRepository,
  );

  @override
  Future<DataState<List<TempleEntity>>> call(formData) async =>
      await _templeRepository.getTempleList(formData);
}
