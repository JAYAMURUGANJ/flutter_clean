import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/temple/domain/entities/temple.dart';

import '../../features/temple/presentation/pages/home/temple_list.dart';
import '../../features/temple/presentation/pages/temple_detail/temple_details.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const TempleList());

      case '/ArticleDetails':
        return _materialRoute(
            TempleDetailsView(temple: settings.arguments as TempleEntity));

      default:
        return _materialRoute(const TempleList());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
