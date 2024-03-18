import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../features/temple/domain/entities/temple.dart';
import '../../features/temple/presentation/pages/home/temple_list.dart';
import '../../features/temple/presentation/pages/temple_detail/temple_details.dart';
import '../common/page/dio_exception_screen.dart';
import '../common/page/something_went_wrong_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const TempleList());

      case '/TempleDetails':
        return _materialRoute(
            TempleDetailsView(temple: settings.arguments as TempleEntity));

      case '/SomthingWentWrong':
        return _materialRoute(
            SomethingWentWrong(error: settings.arguments as String));
      case '/DioException':
        return _materialRoute(
            DioExceptionScreen(error: settings.arguments as DioException));

      default:
        return _materialRoute(const TempleList());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
