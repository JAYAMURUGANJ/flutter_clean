// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element

part of 'ITMS_API_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _HRCEApiService implements HRCEApiService {
  _HRCEApiService(
    this._dio,
  );
  final Dio _dio;
  @override
  Future<HttpResponse<ApiFormData>> getTempleList(
      Map<String, dynamic> json) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(json);
    final _result = await _dio.fetch<List>(
      _setStreamType<HttpResponse<ApiFormData>>(
        Options(
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
            .copyWith(
              baseUrl: _combineBaseUrls(
                _dio.options.baseUrl,
                dotenv.env['BASE_URL'],
              ),
            ),
      ),
    );
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

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
