import 'package:dio/dio.dart';

abstract class DataState<T> {
  final String? responseStatus;
  final T? resultSet;
  final DioException? error;

  const DataState({
    this.responseStatus,
    this.resultSet,
    this.error,
  });
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T? resultset, String responseStatus)
      : super(resultSet: resultset, responseStatus: responseStatus);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}
