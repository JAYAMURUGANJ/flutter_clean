import 'package:news_app_clean_architecture/features/dashboard/domain/entities/whats_new.dart';
import 'package:news_app_clean_architecture/features/dashboard/domain/repository/whats_new_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class WhatsNewUseCase
    implements UseCase<DataState<List<WhatsNewEntity>>, void> {
  final WhatsNewRepository _whatsNewRepository;

  WhatsNewUseCase(
    this._whatsNewRepository,
  );

  @override
  Future<DataState<List<WhatsNewEntity>>> call(formData, serviceId) async =>
      await _whatsNewRepository.getResponse(formData, serviceId);
}
