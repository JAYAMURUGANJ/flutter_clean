part of 'worship_god_list_bloc.dart';

class WorshipGodListState {
  final List<dynamic>? worship;
  final String? responseStatus;
  final DioException? error;
  const WorshipGodListState({this.worship, this.responseStatus, this.error});
}

class WorshipInitial extends WorshipGodListState {}

class WorshipLoading extends WorshipGodListState {
  const WorshipLoading();
}

class WorshipLoaded extends WorshipGodListState {
  const WorshipLoaded(List<WorshipGodEntity> worship) : super(worship: worship);
}

class WorshipLoadingSomthingWentWrong extends WorshipGodListState {
  const WorshipLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class WorshipLoadingError extends WorshipGodListState {
  const WorshipLoadingError(DioException error) : super(error: error);
}
