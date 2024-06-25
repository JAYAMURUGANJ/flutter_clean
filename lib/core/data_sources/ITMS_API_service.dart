// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/form_data.dart';
import '/config/constants.dart';

part 'ITMS_API_service.g.dart';

@RestApi(baseUrl: ApiCredentials.baseUrl)
abstract class HRCEApiService {
  // factory HRCEApiService(Dio dio) = _HRCEApiService;

  factory HRCEApiService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(headers: {
      "Accept": "application/json",
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=9oppotqtb4lr15s2eif0asnqap'
    });
    return _HRCEApiService(dio);
  }

  @POST('')
  Future<HttpResponse<ApiFormData>> getTempleList(
      @Body() Map<String, dynamic> json);
}
