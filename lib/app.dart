import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'config/routes/routes.dart';
import 'config/theme/app_themes.dart';
import 'config/theme/color_schemes.g.dart';
import 'features/home/presentation/bloc/bottom_navigation/bottom_navigation_cubit.dart';
import 'features/settings/presentation/bloc/theme/theme_bloc.dart';
import 'features/temple_details/presentation/bloc/temple_info/temple_info_bloc.dart';
import 'features/temple_details/presentation/bloc/temple_timing/temple_timing_bloc.dart';
import 'features/temple_list/presentation/bloc/itms/itms_bloc.dart';
import 'features/temple_list/presentation/bloc/itms/itms_event.dart';
import 'injection_container.dart';
import 'splash.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

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
    return LocaleBuilder(builder: (Locale? locale) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<ITMSBloc>(
            create: (context) => sl()..add(GetTempleList()),
          ),
          BlocProvider<BottomNavigationCubit>(create: (context) => sl()),
          BlocProvider<ThemeBloc>(create: (context) => sl()),
          BlocProvider<TempleInfoBloc>(create: (context) => sl()),
          BlocProvider<TempleTimingBloc>(create: (context) => sl()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: Locales.delegates,
              supportedLocales: Locales.supportedLocales,
              locale: locale,
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
              home: const SplashScreen(),
            );
          },
        ),
      );
    });
  }
}
