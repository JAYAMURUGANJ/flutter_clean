import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../config/common/class/cryption.dart';
import '../../../../config/constants.dart';
import '../../../../core/data_sources/ITMS_API_service.dart';
import '../../../../core/models/encrypted_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/facility_repository.dart';
import '../model/facility.dart';

class FacilityRepositoryImpl implements FacilityRepository {
  final HRCEApiService _apiService;
  FacilityRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<Facility>>> getResponse(formData, serviceId) async {
    try {
      final httpResponse = await _apiService.getTempleList({
        'service_requester': ApiCredentials.serviceRequester,
        'form_data': formData,
        'service_id': serviceId
      });

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        String serverDecryptedResponse =
            Authentication().decrypt(httpResponse.data.formData);
        var serverJsonResponse =
            await compute(jsonDecode, serverDecryptedResponse);
        log(serverJsonResponse.toString(),
            name: "FACILITY INFO", time: DateTime.now());
        String responseStatus =
            EncryptedResponse.fromJson(serverJsonResponse[0]).responseStatus!;

        if (responseStatus.isNotEmpty) {
          List<Facility> resultSet =
              EncryptedResponse.fromJson(serverJsonResponse[0])
                  .resultSet!
                  .map<Facility>((dynamic i) =>
                      Facility.fromMap(i as Map<String, dynamic>))
                  .toList();
          return DataSuccess(resultSet, responseStatus);
        } else {
          //condition for ---- [{"result_set":null,"response_status":""}]
          return const DataSuccess([
            Facility(
                errorCode: "ITMSSE01",
                responseDesc: "🚫 ITMS-Server,\nFacility return NULL value❗")
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
