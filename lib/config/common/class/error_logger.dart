import 'package:flutter/material.dart';

class ErrorLogger {
  void logError(FlutterErrorDetails details) async {
    //FlutterError.dumpErrorToConsole(details);
    _sendToServer(details.exceptionAsString(), details.stack.toString());
  }

  void log(Object data, StackTrace stackTrace) async {
    // print(data);
    // print(stackTrace);
    _sendToServer(data.toString(), stackTrace.toString());
  }

  void _sendToServer(String a, String b) async {
    // log implementation to send error to ITMS server
  }
}
