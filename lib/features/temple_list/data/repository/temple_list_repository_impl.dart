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
import '../../domain/repository/temple_list_repository.dart';
import '../models/temple_list.dart';

class ItmsRepositoryImpl implements TempleListRepository {
  final HRCEApiService _apiService;
  ItmsRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<Temple>>> getTempleList(formData, serviceId) async {
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
        log(serverJsonResponse.toString(),
            name: "TEMPLE MASTER", time: DateTime.now());
        String responseStatus =
            EncryptedResponse.fromJson(serverJsonResponse[0])
                .responseStatus
                .toString();

        if (responseStatus.isNotEmpty) {
          List<Temple> resultSet =
              EncryptedResponse.fromJson(serverJsonResponse[0])
                  .resultSet!
                  .map<Temple>(
                      (dynamic i) => Temple.fromJson(i as Map<String, dynamic>))
                  .toList();
          return DataSuccess(resultSet, responseStatus);
        } else {
          //condition for ---- [{"result_set":null,"response_status":""}]
          return const DataSuccess([
            Temple(
                errorCode: "ITMSSE01",
                responseDesc: "🚫 ITMS-Server,\nTemple List return NULL value❗")
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
