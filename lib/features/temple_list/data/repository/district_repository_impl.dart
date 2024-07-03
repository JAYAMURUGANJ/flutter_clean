import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/repository/district_repository.dart';
import '../models/district.dart';
import '/config/common/class/cryption.dart';
import '/config/constants.dart';
import '/core/data_sources/ITMS_API_service.dart';
import '/core/models/encrypted_response.dart';
import '/core/resources/data_state.dart';

class DistrictRepositoryImpl implements DistrictRepository {
  final HRCEApiService _apiService;
  DistrictRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<District>>> getResponse(formData, serviceId) async {
    try {
      final httpResponse = await _apiService.getTempleList({
        'service_requester': ApiCredentials.serviceRequester,
        'form_data': formData,
        'service_id': serviceId
      });

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        String serverserverDecryptedResponse =
            Authentication().decrypt(httpResponse.data.formData);
        var serverJsonResponse =
            await compute(jsonDecode, serverserverDecryptedResponse);
        // debugPrint(" aa  ==> $serverJsonResponse");
        log(serverJsonResponse.toString(),
            name: "District MASTER", time: DateTime.now());
        String responseStatus =
            EncryptedResponse.fromJson(serverJsonResponse[0])
                .responseStatus
                .toString();

        if (responseStatus.isNotEmpty) {
          List<District> resultSet =
              EncryptedResponse.fromJson(serverJsonResponse[0])
                  .resultSet!
                  .map<District>((dynamic i) =>
                      District.fromMap(i as Map<String, dynamic>))
                  .toList();
          return DataSuccess(resultSet, responseStatus);
        } else {
          //condition for ---- [{"result_set":null,"response_status":""}]
          return const DataSuccess([
            District(
                errorCode: "ITMSSE01",
                responseDesc:
                    "🚫 ITMS-Server,\nDistrict Gods return NULL value❗")
          ], "FAILURE");
        }
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            error: httpResponse.response.statusMessage,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
