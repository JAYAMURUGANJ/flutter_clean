import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../features/ticket_booking/presentation/widgets/payment_splash.dart';
import '../common/pages/error/dio_exception_screen.dart';
import '../common/pages/error/something_went_wrong_screen.dart';
import '/features/dashboard/presentation/pages/live_telecast.dart';
import '/features/event_calendar/presentation/pages/event_calendar.dart';
import '/features/home/presentation/pages/home.dart';
import '/features/settings/presentation/pages/settings.dart';
import '/features/temple_details/presentation/pages/temple_details.dart';
import '/features/temple_details/presentation/widgets/google_map_location.dart';
import '/features/temple_list/domain/entities/itms_response.dart';
import '/features/temple_list/presentation/pages/temple_list.dart';
import '/features/ticket_booking/presentation/pages/booking_service.dart';
import '/features/ticket_booking/presentation/pages/paid_service.dart';
import '/features/ticket_booking/presentation/pages/ticket_status.dart';
import '/splash.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const SplashScreen());
      case 'Home':
        return _materialRoute(const Home());
      case '/TempleDetails':
        return _materialRoute(TempleDetailsView(
            temple: settings.arguments as ItmsResponseEntity));
      case '/TempleList':
        return _materialRoute(const TempleListPage());
      case '/PaidService':
        return _materialRoute(const PaidServicePage());
      case '/BookingService':
        return _materialRoute(const BookingServicePage());
      case '/Settings':
        return _materialRoute(const Settings());
      case '/Events':
        return _materialRoute(const TempleEventCalendar());
      case '/Livestream':
        return _materialRoute(const TempleLiveTeleCasts());
      case '/PayStatus':
        return _materialRoute(const PaymentStatus());
      case '/PaySplash':
        return _materialRoute(const PaymentSplashScreen());
      case '/NearByTemples':
        return _materialRoute(NearByTemplesWidget(
            data: settings.arguments as Map<String, dynamic>));
      case '/SomthingWentWrong':
        return _materialRoute(
            SomethingWentWrong(error: settings.arguments as String));
      case '/DioException':
        return _materialRoute(
            DioExceptionScreen(error: settings.arguments as DioException));

      default:
        return _materialRoute(const TempleListPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
