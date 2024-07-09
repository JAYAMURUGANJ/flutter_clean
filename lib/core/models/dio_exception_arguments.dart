import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioExceptionArguments {
  final VoidCallback onRefresh;
  final DioException error;

  DioExceptionArguments({required this.onRefresh, required this.error});
}
