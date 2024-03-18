import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/config/constants/constants.dart';

import '../class/exception.dart';
import '../widget/network_image_cache.dart';

class DioExceptionScreen extends StatelessWidget {
  final DioException error;
  const DioExceptionScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiException ae = ApiException();
    String errorMessage = ae.getExceptionMessage(error).errorMsg;
    String errorDescription = ae.getExceptionMessage(error).description;
    return Scaffold(
      body: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(
                    start: 14, end: 14, bottom: 7, top: 7),
                height: MediaQuery.of(context).size.width / 2.2,
                child: buildImage(context, NetworkImages.dioError),
              ),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent, fontSize: 20),
              ),
              Text(
                errorDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
