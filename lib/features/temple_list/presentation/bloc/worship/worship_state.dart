part of 'worship_bloc.dart';

class WorshipState {
  final List<dynamic>? worship;
  final String? responseStatus;
  final DioException? error;
  const WorshipState({this.worship, this.responseStatus, this.error});
}

class WorshipInitial extends WorshipState {}

class WorshipLoading extends WorshipState {
  const WorshipLoading();
}

class WorshipLoaded extends WorshipState {
  const WorshipLoaded(List<WorshipEntity> worship) : super(worship: worship);
}

class WorshipLoadingSomthingWentWrong extends WorshipState {
  const WorshipLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class WorshipLoadingError extends WorshipState {
  const WorshipLoadingError(DioException error) : super(error: error);
}
