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
import '../../domain/repository/contact_details_repository.dart';
import '../model/contact_details.dart';

class ContactDetailsRepositoryImpl implements ContactDetailsRepository {
  final HRCEApiService _apiService;
  ContactDetailsRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<ContactDetails>>> getResponse(
      formData, serviceId) async {
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
            name: "CONTACT DETAILS", time: DateTime.now());
        String responseStatus =
            EncryptedResponse.fromJson(serverJsonResponse[0]).responseStatus!;

        if (responseStatus.isNotEmpty) {
          List<ContactDetails> resultSet =
              EncryptedResponse.fromJson(serverJsonResponse[0])
                  .resultSet!
                  .map<ContactDetails>((dynamic i) =>
                      ContactDetails.fromMap(i as Map<String, dynamic>))
                  .toList();
          return DataSuccess(resultSet, responseStatus);
        } else {
          return const DataSuccess([
            ContactDetails(
                errorCode: "ITMSSE01",
                responseDesc:
                    "🚫 ITMS-Server,\nContact Details return NULL value❗")
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
