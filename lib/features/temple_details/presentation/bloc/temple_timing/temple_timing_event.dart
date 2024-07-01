part of 'temple_timing_bloc.dart';

abstract class TempleTimingEvent {
  const TempleTimingEvent();
}

class GetTempleTiming extends TempleTimingEvent {
  String templeId;
  GetTempleTiming({
    required this.templeId,
  });
}
