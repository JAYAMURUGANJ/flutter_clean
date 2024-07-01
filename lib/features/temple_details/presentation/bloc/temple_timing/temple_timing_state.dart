part of 'temple_timing_bloc.dart';

abstract class TempleTimingState {
  final List<dynamic>? templeTiming;
  final String? responseStatus;
  final DioException? error;
  const TempleTimingState({this.templeTiming, this.responseStatus, this.error});
}

class TempleTimingInitial extends TempleTimingState {}

class TempleTimingLoading extends TempleTimingState {
  const TempleTimingLoading();
}

class TempleTimingLoaded extends TempleTimingState {
  const TempleTimingLoaded(List<TempleTimingEntity> templeTiming)
      : super(templeTiming: templeTiming);
}

class TempleTimingLoadingSomthingWentWrong extends TempleTimingState {
  const TempleTimingLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class TempleTimingLoadingError extends TempleTimingState {
  const TempleTimingLoadingError(DioException error) : super(error: error);
}
