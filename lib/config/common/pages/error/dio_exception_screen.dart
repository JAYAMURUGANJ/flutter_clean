import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';

import '../../../../core/models/dio_exception_arguments.dart';
import '../../class/exception.dart';
import '/config/constants.dart';

class DioExceptionScreen extends StatelessWidget {
  final DioExceptionArguments onException;
  const DioExceptionScreen({Key? key, required this.onException})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiException ae = ApiException();
    String errorMessage = ae.getExceptionMessage(onException.error).errorMsg;
    String errorDescription =
        ae.getExceptionMessage(onException.error).description;
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
                child: Image.asset(LocalImages().dioError),
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
              10.ph,
              FilledButton.icon(
                onPressed: onException.onRefresh,
                label: const LocaleText("refresh"),
                icon: const Icon(Icons.refresh),
              )
            ],
          ),
        ),
      ),
    );
  }
}
