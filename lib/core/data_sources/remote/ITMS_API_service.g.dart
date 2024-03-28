// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ITMS_API_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _HRCEApiService implements HRCEApiService {
  _HRCEApiService(this._dio) {
    baseUrl ??= ApiCredentials.baseUrl;
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<ApiFormData>> getTempleList(
      Map<String, dynamic> json) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    print("Dio request: $_data");
    _data.addAll(json);
    final _result = await _dio.fetch<List>(_setStreamType<FormData>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiFormData.fromJson(_result.data![0]);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
