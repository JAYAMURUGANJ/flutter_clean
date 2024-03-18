import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app_clean_architecture/core/models/encrypted_response.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/temple/data/models/temple.dart';
import 'package:news_app_clean_architecture/features/temple/domain/repository/temple_repository.dart';

import '../../../../config/common/class/cryption.dart';
import '../../../../core/data_sources/remote/news_api_service.dart';

class TempleRepositoryImpl implements TempleRepository {
  final HRCEApiService _apiService;
  TempleRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<TempleModel>>> getTempleList(formData) async {
    try {
      final httpResponse = await _apiService.getTempleList({
        'service_requester': "Constants.serviceRequester",
        'form_data': formData,
        'service_id': '7019'
      });

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        String decryptedResponse =
            Authentication().decrypt(httpResponse.data.formData);
        log("TEMPLE LIST");
        log("API RESPONSE", name: decryptedResponse);
        var clientJsonResponse = await compute(jsonDecode, decryptedResponse);
        String responseStatus =
            EncryptedResponse.fromJson(clientJsonResponse[0]).responseStatus!;

        if (responseStatus.isNotEmpty) {
          List<TempleModel> resultSet =
              EncryptedResponse.fromJson(clientJsonResponse[0])
                  .resultSet!
                  .map<TempleModel>((dynamic i) =>
                      TempleModel.fromJson(i as Map<String, dynamic>))
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
        log("The request was made and the server responded with a status code.That falls out of the range of 2xx and is also not 304!",
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
        log("Something happened in setting up or sending the request that triggered an Error!",
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
