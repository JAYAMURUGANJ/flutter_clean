import 'package:dio/dio.dart';

import '../../../domain/entities/temple_list_response.dart';

abstract class TempleListState {
  final List<dynamic>? templeList;
  final String? responseStatus;
  final DioException? error;

  const TempleListState({this.responseStatus, this.templeList, this.error});
}

class TempleListLoading extends TempleListState {
  const TempleListLoading();
}

class TempleListLoaded extends TempleListState {
  const TempleListLoaded(List<ItmsResponseEntity> templeList)
      : super(templeList: templeList);
}

class FilteredTempleListLoaded extends TempleListState {
  const FilteredTempleListLoaded(List<ItmsResponseEntity> templeList)
      : super(templeList: templeList);
}

class TempleListLoadingSomthingWentWrong extends TempleListState {
  const TempleListLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class TempleListLoadingError extends TempleListState {
  const TempleListLoadingError(DioException error) : super(error: error);
}
