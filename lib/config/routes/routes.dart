import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/core/models/dio_exception_arguments.dart';
import 'package:news_app_clean_architecture/features/onboarding/presentation/pages/onboarding.dart';
import 'package:news_app_clean_architecture/features/temple_details/data/model/location_info.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/photo_gallery_widget.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/speciality_widget.dart';

import '/features/dashboard/presentation/pages/live_telecast.dart';
import '/features/event_calendar/presentation/pages/event_calendar.dart';
import '/features/home/presentation/pages/home.dart';
import '/features/settings/presentation/pages/settings.dart';
import '/features/temple_details/presentation/pages/temple_details.dart';
import '/features/temple_details/presentation/widgets/google_map_location.dart';
import '/features/temple_list/presentation/pages/temple_list.dart';
import '/features/ticket_booking/presentation/pages/booking_service.dart';
import '/features/ticket_booking/presentation/pages/paid_service.dart';
import '/features/ticket_booking/presentation/pages/ticket_status.dart';
import '../../features/temple_details/domain/entities/speciality.dart';
import '../../features/temple_details/presentation/pages/loading_page.dart';
import '../../features/temple_details/presentation/widgets/facility_widget.dart';
import '../../features/temple_list/domain/entities/temple_list.dart';
import '../../features/ticket_booking/presentation/widgets/payment_splash.dart';
import '../common/pages/error/dio_exception_screen.dart';
import '../common/pages/error/something_went_wrong_screen.dart';
import '../common/pages/splash.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _animatedRoute(const SplashScreen());
      case '/OnBoarding':
        return _materialRoute(const OnboardingScreen());
      case 'Home':
        return _animatedRoute(const Home());
      case '/TempleDetails':
        return _animatedRoute(
            TempleDetailsView(temple: settings.arguments as TempleEntity));
      case '/TempleList':
        return _materialRoute(const TempleListPage());
      case '/PaidService':
        return _animatedRoute(const PaidServicePage());
      case '/BookingService':
        return _animatedRoute(const BookingServicePage());
      case '/Settings':
        return _materialRoute(const Settings());
      case '/Events':
        return _animatedRoute(const TempleEventCalendar());
      case '/Livestream':
        return _animatedRoute(const TempleLiveTeleCasts());
      case '/PayStatus':
        return _animatedRoute(const PaymentStatus());
      case '/PaySplash':
        return _animatedRoute(const PaymentSplashScreen());
      case '/loading':
        return _animatedRoute(const LoadingPage());
      case '/NearByTemples':
        return _animatedRoute(
            NearByTemplesWidget(data: settings.arguments as LocationInfo));
      case '/PhotoGallery':
        return _materialRoute(
            PhotoGalleryWidget(templeData: settings.arguments as TempleEntity));
      case '/Speciality':
        return _materialRoute(SpecialityWidget(
            specialityList: settings.arguments as List<SpecialityEntity>));
      case '/Facility':
        return _animatedRoute(
            FacilityWidget(templeData: settings.arguments as TempleEntity));
      case '/SomthingWentWrong':
        return _animatedRoute(
            SomethingWentWrong(error: settings.arguments as String));
      case '/DioException':
        return _animatedRoute(DioExceptionScreen(
            onException: settings.arguments as DioExceptionArguments));

      default:
        return _animatedRoute(const TempleListPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> _animatedRoute(Widget view) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => view,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var fadeTween = Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.fastEaseInToSlowEaseOut));
        var scaleTween = Tween(begin: 0.8, end: 1.0)
            .chain(CurveTween(curve: Curves.fastEaseInToSlowEaseOut));

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        );
      },
    );
  }
}
