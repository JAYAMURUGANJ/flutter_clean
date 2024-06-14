import 'package:dio/dio.dart';

import '../../../domain/entities/itms_response.dart';

abstract class ITMSState {
  final List<dynamic>? templeList;
  final String? responseStatus;
  final DioException? error;

  const ITMSState({this.responseStatus, this.templeList, this.error});
}

class TempleListLoading extends ITMSState {
  const TempleListLoading();
}

class TempleListLoaded extends ITMSState {
  const TempleListLoaded(List<ItmsResponseEntity> templeList)
      : super(templeList: templeList);
}

class FilteredTempleListLoaded extends ITMSState {
  const FilteredTempleListLoaded(List<ItmsResponseEntity> templeList)
      : super(templeList: templeList);
}

class TempleListLoadingSomthingWentWrong extends ITMSState {
  const TempleListLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class TempleListLoadingError extends ITMSState {
  const TempleListLoadingError(DioException error) : super(error: error);
}
