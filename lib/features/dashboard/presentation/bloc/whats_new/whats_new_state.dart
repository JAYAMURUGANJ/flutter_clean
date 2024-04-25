part of 'whats_new_bloc.dart';

abstract class WhatsNewState {
  final List<dynamic>? whatsNew;
  final String? responseStatus;
  final DioException? error;
  const WhatsNewState({this.whatsNew, this.responseStatus, this.error});
}

class WhatsNewInitial extends WhatsNewState {}

class WhatsNewLoading extends WhatsNewState {
  const WhatsNewLoading();
}

class WhatsNewLoaded extends WhatsNewState {
  const WhatsNewLoaded(List<WhatsNewEntity> whatsNew)
      : super(whatsNew: whatsNew);
}

class WhatsNewLoadingSomthingWentWrong extends WhatsNewState {
  const WhatsNewLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class WhatsNewLodingError extends WhatsNewState {
  const WhatsNewLodingError(DioException error) : super(error: error);
}
