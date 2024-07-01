part of 'live_events_bloc.dart';

abstract class LiveEventsEvent {
  const LiveEventsEvent();
}

class GetLiveEvents extends LiveEventsEvent {
  String? templeId;
  GetLiveEvents({
    this.templeId,
  });
}
