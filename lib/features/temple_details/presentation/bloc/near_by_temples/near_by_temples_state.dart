part of 'near_by_temples_bloc.dart';

abstract class NearByTemplesState {
  final List<dynamic>? nearByTemples;
  final String? responseStatus;
  final DioException? error;
  const NearByTemplesState(
      {this.nearByTemples, this.responseStatus, this.error});
}

class NearByTemplesInitial extends NearByTemplesState {}

class NearByTemplesLoading extends NearByTemplesState {
  const NearByTemplesLoading();
}

class NearByTemplesLoaded extends NearByTemplesState {
  const NearByTemplesLoaded(List<NearByTemplesEntity> nearByTemples)
      : super(nearByTemples: nearByTemples);
}

class NearByTemplesLoadingSomthingWentWrong extends NearByTemplesState {
  const NearByTemplesLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class NearByTemplesLodingError extends NearByTemplesState {
  const NearByTemplesLodingError(DioException error) : super(error: error);
}
