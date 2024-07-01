import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '/config/common/class/cryption.dart';
import '/config/constants.dart';
import '/core/data_sources/ITMS_API_service.dart';
import '/core/models/encrypted_response.dart';
import '/core/resources/data_state.dart';
import '../../domain/repository/worship_god_list_repository.dart';
import '../models/worship.dart';

class WorshipRepositoryImpl implements WorshipRepository {
  final HRCEApiService _apiService;
  WorshipRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<WorshipGod>>> getResponse(formData, serviceId) async {
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
            name: "WORSHIP GOD MASTER", time: DateTime.now());
        debugPrint(serverserverDecryptedResponse.toString());
        String responseStatus =
            EncryptedResponse.fromJson(serverJsonResponse[0])
                .responseStatus
                .toString();

        if (responseStatus.isNotEmpty) {
          List<WorshipGod> resultSet =
              EncryptedResponse.fromJson(serverJsonResponse[0])
                  .resultSet!
                  .map<WorshipGod>((dynamic i) =>
                      WorshipGod.fromMap(i as Map<String, dynamic>))
                  .toList();
          return DataSuccess(resultSet, responseStatus);
        } else {
          //condition for ---- [{"result_set":null,"response_status":""}]
          return const DataSuccess([
            WorshipGod(
                errorCode: "ITMSSE01",
                responseDesc:
                    "🚫 ITMS-Server,\nWorship Gods return NULL value❗")
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
