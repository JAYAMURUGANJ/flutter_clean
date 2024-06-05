import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/repository/near_by_temples_repository.dart';
import '../model/near_by_temples.dart';
import '/config/common/class/cryption.dart';
import '/config/constants.dart';
import '/core/data_sources/ITMS_API_service.dart';
import '/core/models/encrypted_response.dart';
import '/core/resources/data_state.dart';

class NearByTemplesRepositoryImpl implements NearByTemplesRepository {
  final HRCEApiService _apiService;
  NearByTemplesRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<NearByTemples>>> getResponse(
      formData, serviceId) async {
    try {
      final httpResponse = await _apiService.getTempleList({
        'service_requester': ApiCredentials.serviceRequester,
        'form_data': formData,
        'service_id': serviceId
      });

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        String decryptedResponse =
            Authentication().decrypt(httpResponse.data.formData);
        log(decryptedResponse, name: "NEAR BY TEMPLE");
        var clientJsonResponse = await compute(jsonDecode, decryptedResponse);
        String responseStatus =
            EncryptedResponse.fromJson(clientJsonResponse[0]).responseStatus!;

        if (responseStatus.isNotEmpty) {
          List<NearByTemples> resultSet =
              EncryptedResponse.fromJson(clientJsonResponse[0])
                  .resultSet!
                  .map<NearByTemples>((dynamic i) =>
                      NearByTemples.fromMap(i as Map<String, dynamic>))
                  .toList();
          return DataSuccess(resultSet, responseStatus);
        } else {
          log("Server Response NULL", error: decryptedResponse);
          return DataSuccess([], "Server Response NULL: $decryptedResponse");
        }
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log("",
            name:
                "The request was made and the server responded with a status code.That falls out of the range of 2xx and is also not 304!",
            error: e);
        return DataFailed(
          DioException(
            type: e.type,
            error: e.error,
            message: e.message,
            response: e.response,
            stackTrace: e.stackTrace,
            requestOptions: e.requestOptions,
          ),
        );
      } else {
        log("",
            name:
                "Something happened in setting up or sending the request that triggered an Error!",
            error: e.type);
        return DataFailed(
          DioException(
            type: e.type,
            error: e.error,
            message: e.message,
            response: e.response,
            stackTrace: e.stackTrace,
            requestOptions: e.requestOptions,
          ),
        );
      }
    }
  }
}
