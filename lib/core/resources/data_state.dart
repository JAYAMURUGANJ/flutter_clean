import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? resultSet;
  final String? responseStatus;
  final DioException? error;

  const DataState({
    this.resultSet,
    this.responseStatus,
    this.error,
  });
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T? resultSet, String? responseStatus)
      : super(resultSet: resultSet, responseStatus: responseStatus);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}
