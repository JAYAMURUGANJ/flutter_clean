part of 'near_by_temples_bloc.dart';

abstract class NearbyTemplesEvent {
  const NearbyTemplesEvent();
}

class GetNearByTemplesEvent extends NearbyTemplesEvent {
  final String templeId;
  GetNearByTemplesEvent({
    required this.templeId,
  });
}
