part of 'live_events_bloc.dart';

abstract class LiveEventsState {
  final List<dynamic>? liveEvents;
  final String? responseStatus;
  final DioException? error;
  const LiveEventsState({this.liveEvents, this.responseStatus, this.error});
}

class LiveEventsInitial extends LiveEventsState {}

class LiveEventsLoading extends LiveEventsState {
  const LiveEventsLoading();
}

class LiveEventsLoaded extends LiveEventsState {
  const LiveEventsLoaded(List<LiveEventsEntity> liveEvents)
      : super(liveEvents: liveEvents);
}

class LiveEventsSomthingWentWrong extends LiveEventsState {
  const LiveEventsSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class LiveEventsLodingError extends LiveEventsState {
  const LiveEventsLodingError(DioException error) : super(error: error);
}
