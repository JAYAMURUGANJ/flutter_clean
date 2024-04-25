import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/live_events.dart';
import '../repository/live_events_repository.dart';

class LiveEventsUseCase
    implements UseCase<DataState<List<LiveEventsEntity>>, void> {
  final LiveEventsRepository _liveEventsRepository;

  LiveEventsUseCase(
    this._liveEventsRepository,
  );

  @override
  Future<DataState<List<LiveEventsEntity>>> call(formData, serviceId) async =>
      await _liveEventsRepository.getResponse(formData, serviceId);
}
