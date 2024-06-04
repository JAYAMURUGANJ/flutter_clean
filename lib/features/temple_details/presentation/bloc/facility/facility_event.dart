part of 'facility_bloc.dart';

class FacilityEvent {
  const FacilityEvent();
}

class GetFacilityEvent extends FacilityEvent {
  final String templeId;
  GetFacilityEvent({
    required this.templeId,
  });
}
