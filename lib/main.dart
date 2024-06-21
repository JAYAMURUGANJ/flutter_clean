// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '/app.dart';
import 'config/common/class/app_info.dart';
import 'config/common/class/error_logger.dart';
import 'config/common/class/local_storage.dart';
import 'config/config_loader.dart';
import 'core/bloc/bloc_observer.dart';
import 'injection_container.dart';

void main() {
  runZonedGuarded(
    () async {
      // WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

      //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      Bloc.observer = MyBlocObserver();
      await dotenv.load(fileName: ".env_dev");
      // await dotenv.load(fileName: ".env_uat");
      WidgetsFlutterBinding.ensureInitialized();
      await initializeDependencies();
      await Prefs.init();
      await Locales.init(['ta', 'en']);

      /// endpoint cofiguration
      String envFile = "development";

      const flavor = String.fromEnvironment('FLAVOR');

      switch (flavor) {
        case 'development':
          envFile = "development";
          break;
        case 'staging':
          envFile = "staging";
          break;
        case 'production':
          envFile = "release";
          break;
      }

      // Load the configuration
      final configLoader = ConfigLoader(
          environment: envFile); // Change this based on environment
      final config = await configLoader.load();

      debugPrint("config ===>  ${config.apiBaseUrl}");

      ///===>

      AppInfo().getIPAddress().then((ip) async {
        await Prefs.setString(
            spNetworkIp, ip == null ? "No Network" : ip.toString());
      });
      AppInfo().getAppVersion().then((version) async {
        await Prefs.setString(
            spAppVersion, version == null ? "Not Found" : version.toString());
      });
      FlutterError.onError = FlutterError.presentError;
      runApp(
        DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => const App(), // Wrap your app
        ),
      );
    },
    (error, stackTrace) {
      ErrorLogger().log(error, stackTrace);
    },
  );
}
