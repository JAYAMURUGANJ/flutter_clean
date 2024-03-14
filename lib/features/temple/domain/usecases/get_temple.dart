import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/temple/domain/entities/temple.dart';

import '../repository/temple_repository.dart';

class GetTempleUseCase implements UseCase<DataState<List<TempleEntity>>, void> {
  final TempleRepository _templeRepository;

  String formData;

  GetTempleUseCase(
    this._templeRepository,
    this.formData,
  );

  @override
  Future<DataState<List<TempleEntity>>> call({void params}) =>
      _templeRepository.getTempleList(formData);
}
