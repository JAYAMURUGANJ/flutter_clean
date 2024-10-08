part of 'sculptures_bloc.dart';

class SculpturesState {
  final List<dynamic>? sculptures;
  final SculptureEntity? sculpture;
  final String? responseStatus;
  final DioException? error;

  const SculpturesState(
      {this.sculptures, this.sculpture, this.responseStatus, this.error});
}

class SculpturesInitial extends SculpturesState {}

class SculpturesLoading extends SculpturesState {
  const SculpturesLoading();
}

class SculpturesLoaded extends SculpturesState {
  const SculpturesLoaded(List<SculptureEntity> sculptures)
      : super(sculptures: sculptures);
}

class SculpturesLoadingSomthingWentWrong extends SculpturesState {
  const SculpturesLoadingSomthingWentWrong(String? responseStatus)
      : super(responseStatus: responseStatus);
}

class SculpturesLoadingError extends SculpturesState {
  const SculpturesLoadingError(DioException error) : super(error: error);
}

class SculpturesDescView extends SculpturesState {
  const SculpturesDescView(SculptureEntity sculpture)
      : super(sculpture: sculpture);
}
