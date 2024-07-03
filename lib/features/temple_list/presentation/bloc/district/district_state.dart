part of 'district_bloc.dart';

class DistrictState {
  final List<dynamic>? district;
  final String? responseStatus;
  final DioException? error;

  const DistrictState({this.responseStatus, this.district, this.error});
}

class DistrictInitial extends DistrictState {}

class DistrictLoading extends DistrictState {
  const DistrictLoading();
}

class DistrictLoaded extends DistrictState {
  const DistrictLoaded(List<DistrictEntity> district)
      : super(district: district);
}

class DistrictLoadingSomthingWentWrong extends DistrictState {
  const DistrictLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class DistrictLoadingError extends DistrictState {
  const DistrictLoadingError(DioException error) : super(error: error);
}
