part of 'shrines_bloc.dart';

class ShrinesState {
  final List<dynamic>? shrines;
  final String? responseStatus;
  final DioException? error;
  const ShrinesState({this.shrines, this.responseStatus, this.error});
}

class ShrinesInitial extends ShrinesState {}

class ShrinesLoading extends ShrinesState {
  const ShrinesLoading();
}

class ShrinesLoaded extends ShrinesState {
  const ShrinesLoaded(List<ShrinesDetailsEntity> shrines)
      : super(shrines: shrines);
}

class ShrinesLoadingSomthingWentWrong extends ShrinesState {
  const ShrinesLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class ShrinesLodingError extends ShrinesState {
  const ShrinesLodingError(DioException error) : super(error: error);
}
