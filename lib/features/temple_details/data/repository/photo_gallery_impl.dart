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
import '../../domain/repository/photo_gallery_repository .dart';
import '../model/photo_gallery.dart';

class PhotoGalleryRepositoryImpl implements PhotoGalleryRepository {
  final HRCEApiService _apiService;
  PhotoGalleryRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<PhotoGallery>>> getResponse(formData, serviceId) async {
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
            name: "API RESPONSE", time: DateTime.now());
        String responseStatus =
            EncryptedResponse.fromJson(serverJsonResponse[0]).responseStatus!;

        if (responseStatus.isNotEmpty) {
          List<PhotoGallery> resultSet =
              EncryptedResponse.fromJson(serverJsonResponse[0])
                  .resultSet!
                  .map<PhotoGallery>((dynamic i) =>
                      PhotoGallery.fromMap(i as Map<String, dynamic>))
                  .toList();
          return DataSuccess(resultSet, responseStatus);
        } else {
          return const DataSuccess([
            PhotoGallery(
                errorCode: "ITMSSE01",
                responseDesc:
                    "🚫 ITMS-Server,\nPhoto Gallery return NULL value❗")
          ], "FAILURE");
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
