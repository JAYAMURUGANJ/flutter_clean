part of 'sculptures_bloc.dart';

class SculpturesState {
  final List<dynamic>? sculptures;
  final SculpturesEntity? sculpture;
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
  const SculpturesLoaded(List<SculpturesEntity> sculptures)
      : super(sculptures: sculptures);
}

class SculpturesLoadingSomthingWentWrong extends SculpturesState {
  const SculpturesLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class SculpturesLodingError extends SculpturesState {
  const SculpturesLodingError(DioException error) : super(error: error);
}

class SculpturesDescView extends SculpturesState {
  const SculpturesDescView(SculpturesEntity sculpture)
      : super(sculpture: sculpture);
}
