part of 'speciality_bloc.dart';

class SpecialityState {
  final List<dynamic>? speciality;
  final String? responseStatus;
  final DioException? error;
  const SpecialityState({this.speciality, this.responseStatus, this.error});
}

class SpecialityInitial extends SpecialityState {}

class SpecialityLoading extends SpecialityState {
  const SpecialityLoading();
}

class SpecialityLoaded extends SpecialityState {
  const SpecialityLoaded(List<SpecialityEntity> speciality)
      : super(speciality: speciality);
}

class SpecialityLoadingSomthingWentWrong extends SpecialityState {
  const SpecialityLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class SpecialityLoadingError extends SpecialityState {
  const SpecialityLoadingError(DioException error) : super(error: error);
}
