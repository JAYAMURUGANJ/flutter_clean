import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '/config/constants.dart';
import '/features/dashboard/presentation/bloc/live_events/live_events_bloc.dart';
import '/features/event_calendar/presentation/bloc/calendar_event/calendar_event_bloc.dart';
import '/features/event_calendar/presentation/bloc/calendar_event_details/calendar_event_details_bloc.dart';
import '/features/settings/presentation/bloc/selected_favorite_temples/selected_favorite_temples_cubit.dart';
import '/features/temple_details/presentation/bloc/contact_details/contact_details_bloc.dart';
import '/features/temple_details/presentation/bloc/facility/facility_bloc.dart';
import '/features/temple_details/presentation/bloc/near_by_temples/near_by_temples_bloc.dart';
import '/features/temple_details/presentation/bloc/photo_gallery/photo_gallery_bloc.dart';
import '/features/temple_details/presentation/bloc/photo_gallery_desc/photo_gallery_desc_cubit.dart';
import '/features/temple_details/presentation/bloc/sculptures/sculptures_bloc.dart';
import '/features/temple_details/presentation/bloc/shrines_details/shrines_bloc.dart';
import '/features/temple_details/presentation/bloc/speciality/speciality_bloc.dart';
import '/features/temple_list/presentation/bloc/worship_god_list/worship_god_list_bloc.dart';
import 'config/common/bloc/bloc/connectivity_bloc.dart';
import 'config/common/class/local_language_controller.dart';
import 'config/routes/routes.dart';
import 'config/theme/app_themes.dart';
import 'config/theme/color_schemes.g.dart';
import 'features/dashboard/presentation/bloc/current_location/current_location_bloc.dart';
import 'features/home/presentation/bloc/bottom_navigation/bottom_navigation_cubit.dart';
import 'features/settings/presentation/bloc/theme/theme_bloc.dart';
import 'features/temple_details/presentation/bloc/show_nearby_temples/show_nearby_temples_bloc.dart';
import 'features/temple_details/presentation/bloc/temple_info/temple_info_bloc.dart';
import 'features/temple_details/presentation/bloc/temple_pooja/temple_pooja_bloc.dart';
import 'features/temple_details/presentation/bloc/temple_timing/temple_timing_bloc.dart';
import 'features/temple_list/presentation/bloc/temple_list/temple_list_bloc.dart';
import 'features/temple_list/presentation/bloc/temple_list/temple_list_event.dart';
import 'injection_container.dart';

// ignore: must_be_immutable
class App extends StatefulWidget {
  String environment;
  App({
    Key? key,
    required this.environment,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController =
        Get.put(LocalizationController());
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (context) => ConnectivityBloc(Connectivity()),
        ),
        BlocProvider<TempleListBloc>(
          create: (context) =>
              sl()..add(GetTempleList(seniorgradeTemples: 'Y')),
        ),
        BlocProvider<BottomNavigationCubit>(create: (context) => sl()),
        BlocProvider<ThemeBloc>(create: (context) => sl()),
        BlocProvider<TempleInfoBloc>(create: (context) => sl()),
        BlocProvider<TempleTimingBloc>(create: (context) => sl()),
        BlocProvider<TemplePoojaBloc>(create: (context) => sl()),
        BlocProvider<LiveEventsBloc>(create: (context) => sl()),
        BlocProvider<ContactDetailsBloc>(create: (context) => sl()),
        BlocProvider<CalendarEventBloc>(create: (context) => sl()),
        BlocProvider<CalendarEventDetailsBloc>(create: (context) => sl()),
        BlocProvider<NearbyTemplesBloc>(create: (context) => sl()),
        BlocProvider<ShowNearbyTemplesBloc>(create: (context) => sl()),
        BlocProvider<CurrentLocationBloc>(create: (context) => sl()),
        BlocProvider<ShrinesBloc>(create: (context) => sl()),
        BlocProvider<SculpturesBloc>(create: (context) => sl()),
        BlocProvider<FacilityBloc>(create: (context) => sl()),
        BlocProvider<SpecialityBloc>(create: (context) => sl()),
        BlocProvider<PhotoGalleryBloc>(create: (context) => sl()),
        BlocProvider<PhotoGalleryDescCubit>(create: (context) => sl()),
        BlocProvider<WorshipGodListBloc>(
            create: (context) => sl()..add(GetWorship())),
        BlocProvider<SelectedFavoriteTemplesCubit>(create: (context) => sl()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BetterFeedback(
            child: GetMaterialApp(
              title: Locales.lang == "en"
                  ? ApiCredentials.appName
                  : ApiCredentials.tAppName,
              builder: DevicePreview.appBuilder,
              debugShowCheckedModeBanner:
                  widget.environment == ".env_prod" ? false : true,
              localizationsDelegates: Locales.delegates,
              supportedLocales: Locales.supportedLocales,
              locale: localizationController.locale.value,
              fallbackLocale: const Locale('ta'),
              theme:
                  //FlexThemeData.light(scheme: FlexScheme.barossa),
                  theme().copyWith(
                colorScheme: themeState is LightModeState
                    ? lightColorScheme[themeState.index]
                    : lightColorScheme[0],
              ),
              darkTheme:
                  ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
              themeMode: themeState is DarkModeState
                  ? ThemeMode.dark
                  : ThemeMode.light,
              onGenerateRoute: AppRoutes.onGenerateRoutes,
              initialRoute: "/",
            ),
          );
        },
      ),
    );
  }
}
