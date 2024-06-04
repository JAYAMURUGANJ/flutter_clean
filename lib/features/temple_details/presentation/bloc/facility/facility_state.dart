part of 'facility_bloc.dart';

class FacilityState {
  final List<dynamic>? facility;
  final String? responseStatus;
  final DioException? error;
  const FacilityState({this.facility, this.responseStatus, this.error});
}

class FacilityInitial extends FacilityState {}

class FacilityLoading extends FacilityState {
  const FacilityLoading();
}

class FacilityLoaded extends FacilityState {
  const FacilityLoaded(List<FacilityEntity> facility)
      : super(facility: facility);
}

class FacilityLoadingSomthingWentWrong extends FacilityState {
  const FacilityLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class FacilityLoadingError extends FacilityState {
  const FacilityLoadingError(DioException error) : super(error: error);
}
