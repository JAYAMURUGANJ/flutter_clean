import 'package:dio/dio.dart';

class ApiError {
  String errorMsg;
  String description;
  ApiError({
    required this.errorMsg,
    required this.description,
  });
}

class ApiException {
  ApiError getExceptionMessage(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return ApiError(
            errorMsg: "Bad Response",
            description: "Check Api url or parameters are invalid");
      case DioExceptionType.connectionError:
        return ApiError(
            errorMsg: "Connection Error",
            description: "Check network Connectivity!");
      case DioExceptionType.connectionTimeout:
        return ApiError(
            errorMsg: "Connection Timeout",
            description: "Check network Connectivity!");
      case DioExceptionType.cancel:
        return ApiError(
            errorMsg: "Request Cancelled",
            description: "Check API url or parameters are invalid");
      case DioExceptionType.receiveTimeout:
        return ApiError(
            errorMsg: "Receive Timeout",
            description: "Problem may be your Internet connection or Server");
      case DioExceptionType.unknown:
      default:
        return ApiError(
            errorMsg: "Something Went Wrong!",
            description:
                "Check API url/Network Connectivity or\n parameters are invalid");
    }
  }
}
