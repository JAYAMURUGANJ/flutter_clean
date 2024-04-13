part of 'temple_pooja_bloc.dart';

abstract class TemplePoojaState {
  final List<dynamic>? templePooja;
  final String? responseStatus;
  final DioException? error;
  const TemplePoojaState({this.templePooja, this.responseStatus, this.error});
}

class TemplePoojaInitial extends TemplePoojaState {}

class TemplePoojaLoading extends TemplePoojaState {
  const TemplePoojaLoading();
}

class TemplePoojaLoaded extends TemplePoojaState {
  const TemplePoojaLoaded(List<TemplePoojaEntity> templePooja)
      : super(templePooja: templePooja);
}

class TemplePoojaLoadingSomthingWentWrong extends TemplePoojaState {
  const TemplePoojaLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class TemplePoojaLodingError extends TemplePoojaState {
  const TemplePoojaLodingError(DioException error) : super(error: error);
}
