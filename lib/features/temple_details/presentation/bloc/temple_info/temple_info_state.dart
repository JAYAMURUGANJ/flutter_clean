part of 'temple_info_bloc.dart';

abstract class TempleInfoState {
  final List<dynamic>? templeInfo;
  final String? responseStatus;
  final DioException? error;
  const TempleInfoState({this.templeInfo, this.responseStatus, this.error});
}

class TempleInfoInitial extends TempleInfoState {}

class TempleInfoLoading extends TempleInfoState {
  const TempleInfoLoading();
}

class TempleInfoLoaded extends TempleInfoState {
  const TempleInfoLoaded(List<TempleInfoEntity> templeInfo)
      : super(templeInfo: templeInfo);
}

class TempleInfoLoadingSomthingWentWrong extends TempleInfoState {
  const TempleInfoLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class TempleInfoLodingError extends TempleInfoState {
  const TempleInfoLodingError(DioException error) : super(error: error);
}
